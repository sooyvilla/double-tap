import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:double_tap/app/data/models/user_v1.dart';
import 'package:double_tap/app/domain/datasource/valorant_auth_datasource.dart';
import 'package:jwt_decode/jwt_decode.dart';

import '../../../app/config/config.dart';
import '../utils/headers.dart';

class ValorantApiAuthDatasource extends ValorantAuthDatasource
    with DioConfigService {
  final _prefs = SharedPreferencesConfig.prefs;
  final _requestPrivateAuth = _RequestPrivateAuth();

  @override
  Future<void> validateToken() async {}

  @override
  Future<bool> login(String username, String password) async {
    try {
      await _requestPrivateAuth.getCookies();
      final needOtp =
          await _requestPrivateAuth.getToken(username, password) ?? false;
      if (needOtp) {
        return false;
      }
      await _requestPrivateAuth.getEntitlement();
      return true;
    } catch (e) {
      log('login error: $e', name: 'login error datasource');
      return false;
    }
  }

  @override
  Future<UserV1> getInfoPlayer() async {
    try {
      final accessToken = _prefs?.getString(KeysAuth.accessToken) ?? '';
      final entitlementsToken =
          _prefs?.getString(KeysAuth.entitlementsToken) ?? '';

      final response = await dio.get(
        ValorantUrls.urlUserInfo,
        options: Options(headers: {
          'Authorization': 'Bearer $accessToken',
          'X-Riot-Entitlements-JWT': entitlementsToken,
        }),
      );

      final puuid =
          Jwt.parseJwt(_prefs?.getString(KeysAuth.accessToken) ?? '')['sub']
              as String;

      _prefs?.setString(KeysAuth.puuid, puuid);
      await _requestPrivateAuth.getRegionLoginPlayer();
      final Map<String, dynamic> data = response.data;
      data['identity'] = await _requestPrivateAuth.playerLoadout();
      return UserV1.fromMap(data);
    } catch (e) {
      log('getInfoPlayer error: $e', name: 'getInfoPlayer error');
      rethrow;
    }
  }

  @override
  Future<void> loginWebView(String url) async {
    try {
      await _requestPrivateAuth.getCookies();
      _requestPrivateAuth.saveToken(url);
      await _requestPrivateAuth.getEntitlement();
    } catch (e) {
      log('loginWebView error: $e', name: 'loginWebView error datasource');
      rethrow;
    }
  }
}

class _RequestPrivateAuth with DioConfigService {
  final _prefs = SharedPreferencesConfig.prefs;

  Future<void> getVersionApi() async {
    final versionApi = _prefs?.getString(KeysAuth.versionApi);
    try {
      final response = await dio.get(ValorantUrls.urlVersionApi);

      if (response.statusCode == 200) {
        final versionApiRemote = response.data['data']['version'];
        if (versionApi != versionApiRemote) {
          _prefs?.setString(KeysAuth.versionApi, versionApiRemote);
        }
      }
    } catch (e) {
      log('getVersionApi error: $e', name: 'getVersionApi error');
    } finally {
      if (versionApi == null) {
        _prefs?.setString(KeysAuth.versionApi, '07.00.00.913116');
      }
    }
  }

  Future<Map<String, dynamic>> playerLoadout() async {
    final shard = _prefs?.getString(KeysAuth.shard) ?? '';
    final puuid = _prefs?.getString(KeysAuth.puuid) ?? '';
    try {
      final response = await dio.get(
        ValorantUrls.urlPersonalization(shard, puuid),
        options: Options(headers: getHeaders()),
      );

      return response.data['Identity'];
    } catch (e) {
      log('playerLoadout error: $e', name: 'playerLoadout error');
      rethrow;
    }
  }

  Future<void> getEntitlement() async {
    final accessToken = _prefs?.getString(KeysAuth.accessToken) ?? '';

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

      await _prefs?.setString(KeysAuth.entitlementsToken, entitlementsToken);
    } catch (e) {
      log('getEntitlement error: $e', name: 'getEntitlement error');
      rethrow;
    }
  }

  Future<void> saveToken(String uri) async {
    try {
      final authUrl = (uri);
      final parsedUri = Uri.tryParse(authUrl.replaceFirst('#', '?'));

      if (parsedUri == null || !parsedUri.hasQuery) {
        return;
      }

      final accessToken = parsedUri.queryParameters['access_token'];
      final idToken = parsedUri.queryParameters['id_token'];

      if (accessToken != null) {
        await _prefs?.setString(KeysAuth.accessToken, accessToken);
      }

      if (idToken != null) {
        await _prefs?.setString(KeysAuth.idToken, idToken);
      }
    } catch (e) {
      throw Exception('saveToken error: $e');
    }
  }

  Future<bool?> getToken(String username, String password) async {
    final cookie = _prefs?.getString(KeysAuth.cookie) ?? '';

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
          'remember': true,
          'language': 'en_US',
        },
      );

      if (response.statusCode != 200) throw Exception('Invalid session');

      if (response.data['type'] == 'multifactor') {
        log('Multifactor authentication required');
        return true;
      }

      await saveToken(response.data['response']['parameters']['uri']);
      return false;
    } catch (e) {
      log('getToken error: $e', name: 'getToken error');
      return null;
    }
  }

  Future<void> getCookies() async {
    try {
      await getVersionApi();
      final versionApi = _prefs?.getString(KeysAuth.versionApi);
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

      await _prefs?.setString(KeysAuth.cookie, cookie);
    } catch (e) {
      log('getCookie error: $e', name: 'authCookie error');
      rethrow;
    }
  }

  Future<void> getRegionLoginPlayer() async {
    final idToken = _prefs?.getString(KeysAuth.idToken);
    final accessToken = _prefs?.getString(KeysAuth.accessToken);
    try {
      final response = await dio.put(
        'https://riot-geo.pas.si.riotgames.com/pas/v1/product/valorant',
        data: {'id_token': idToken},
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );

      if (response.statusCode == 200) {
        final region = response.data['affinities']['live'];
        final shard = response.data['affinities']['pbe'];
        _prefs?.setString(KeysAuth.region, region);
        _prefs?.setString(KeysAuth.shard, shard);
      }
    } catch (e) {
      log('getRegionLoginPlayer error: $e', name: 'getRegionLoginPlayer error');
      rethrow;
    }
  }
}
