import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:insane_bolt/app/config/constants/keys.dart';
import 'package:insane_bolt/app/config/constants/valorant_urls.dart';
import 'package:insane_bolt/app/domain/datasource/valorant_auth_datasource.dart';
import 'package:insane_bolt/app/domain/models/user_v1.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../../../app/config/config.dart';

class ValorantApiAuthDatasource extends ValorantAuthDatasource
    with DioConfigService {
  Future<void> _getCookies() async {
    final prefs = SharedPreferencesConfig.prefs;
    try {
      await _getVersionApi();
      final versionApi = prefs?.getString(KeysAuth.versionApi);
      final userAgent =
          'RiotClient/$versionApi rso-auth (Windows; 10;;Professional, x64)';
      final response = await dio.post(
        ValorantUrls.urlAuth,
        data: {
          'client_id': 'play-valorant-web-prod',
          'nonce': '1',
          'redirect_uri': 'https://playvalorant.com/opt_in',
          'response_type': 'token id_token',
          'scope': 'account openid',
        },
        options: Options(
          headers: {
            'User-Agent': userAgent,
          },
        ),
      );

      final setCookie = response.headers['set-cookie'];
      if (setCookie == null || setCookie.isEmpty) {
        throw Exception('No cookies found');
      }

      final cookie = setCookie.map((item) => item.split(';')[0]).join('; ');

      await prefs?.setString(KeysAuth.cookie, cookie);
    } catch (e) {
      log('getCookie error: $e', name: 'authCookie error');
      rethrow;
    }
  }

  Future<bool?> _getToken(String username, String password) async {
    final prefs = SharedPreferencesConfig.prefs;
    final cookie = prefs?.getString(KeysAuth.cookie) ?? '';

    try {
      final response = await dio.put(
        ValorantUrls.urlAuth,
        options: Options(headers: {
          'Cookie': cookie,
        }),
        data: {
          'type': 'auth',
          'username': username,
          'password': password,
          'remember': false,
          'language': 'en_US',
        },
      );

      if (response.statusCode != 200) throw Exception('Invalid session');

      if (response.data['type'] == 'multifactor') {
        log('Multifactor authentication required');
        return true;
      }

      await _saveToken(response.data['response']['parameters']['uri']);
      return false;
    } catch (e) {
      log('getToken error: $e', name: 'getToken error');
      return null;
    }
  }

  Future<void> _saveToken(String uri) async {
    final prefs = SharedPreferencesConfig.prefs;
    try {
      final authUrl = (uri);
      final parsedUri = Uri.tryParse(authUrl.replaceFirst('#', '?'));

      if (parsedUri == null || !parsedUri.hasQuery) {
        return;
      }

      final accessToken = parsedUri.queryParameters['access_token'];

      if (accessToken != null) {
        await prefs?.setString(KeysAuth.accessToken, accessToken);
      }
    } catch (e) {
      throw Exception('saveToken error: $e');
    }
  }

  //todo: implementar esto

  @override
  Future<void> reauthentication() async {
    final prefs = SharedPreferencesConfig.prefs;
    final cookie = prefs?.getString(KeysAuth.cookie) ?? '';

    final versionApi = prefs?.getString(KeysAuth.versionApi);
    final userAgent =
        'RiotClient/$versionApi rso-auth (Windows; 10;;Professional, x64)';

    try {
      final response = await dio.post(ValorantUrls.urlAuth,
          options: Options(headers: {
            'User-Agent': userAgent,
            'Cookie': cookie,
          }),
          data: {
            'client_id': 'play-valorant-web-prod',
            'nonce': 1,
            'redirect_uri': 'https://playvalorant.com/opt_in',
            'response_type': 'token id_token',
            'response_mode': 'query',
            'scope': 'account openid',
          });
      _saveToken(response.data['response']['parameters']['uri']);
        await _getEntitlement();
    } catch (e) {
      log('reauthentication error: $e', name: 'reauthentication error');
      rethrow;
    }
  }

  Future<void> _getEntitlement() async {
    final prefs = SharedPreferencesConfig.prefs;
    final accessToken = prefs?.getString(KeysAuth.accessToken) ?? '';

    try {
      final response = await dio.post(
        ValorantUrls.urlEntitlement,
        options: Options(headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $accessToken',
        }),
        data: {},
      );

      final entitlementsToken = response.data['entitlements_token'];
      if (entitlementsToken == null) {
        throw Exception('Entitlements token not found');
      }

      await prefs?.setString(KeysAuth.entitlementsToken, entitlementsToken);
    } catch (e) {
      log('getEntitlement error: $e', name: 'getEntitlement error');
      rethrow;
    }
  }

  @override
  Future<bool> login(String username, String password) async {
    try {
      await _getCookies();
      final needOtp = await _getToken(username, password) ?? false;
      if (needOtp) {
        return false;
      }
      await _getEntitlement();
      return true;
    } catch (e) {
      log('login error: $e', name: 'login error datasource');
      return false;
    }
  }

  @override
  Future<UserV1> getInfoPlayer() async {
    try {
      final prefs = SharedPreferencesConfig.prefs;

      final accessToken = prefs?.getString(KeysAuth.accessToken) ?? '';
      final entitlementsToken =
          prefs?.getString(KeysAuth.entitlementsToken) ?? '';

      final response = await dio.get(
        ValorantUrls.urlUserInfo,
        options: Options(headers: {
          'Authorization': 'Bearer $accessToken',
          'X-Riot-Entitlements-JWT': entitlementsToken,
        }),
      );

      final puuid =
          Jwt.parseJwt(prefs?.getString(KeysAuth.accessToken) ?? '')['sub']
              as String;

      prefs?.setString(KeysAuth.puuid, puuid);

      return UserV1.fromMap(response.data);
    } catch (e) {
      log('getInfoPlayer error: $e', name: 'getInfoPlayer error');
      rethrow;
    }
  }

  Future<void> _getVersionApi() async {
    final prefs = SharedPreferencesConfig.prefs;
    final versionApi = prefs?.getString(KeysAuth.versionApi);
    try {
      final response = await dio.get(ValorantUrls.urlVersionApi);

      if (response.statusCode == 200) {
        final versionApiRemote = response.data['data']['version'];
        if (versionApi != versionApiRemote) {
          prefs?.setString(KeysAuth.versionApi, versionApiRemote);
        }
      }
    } catch (e) {
      log('getVersionApi error: $e', name: 'getVersionApi error');
    } finally {
      if (versionApi == null) {
        prefs?.setString(KeysAuth.versionApi, '07.00.00.913116');
      }
    }
  }

  @override
  Future<void> loginWebView(String token) async {
    final prefs = SharedPreferencesConfig.prefs;

    await _getCookies();
    prefs?.setString(KeysAuth.accessToken, token);
    await _getEntitlement();
  }
}
