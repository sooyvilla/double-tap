import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../config/config.dart';

class ValorantApiAuth with DioConfigService {
  Future<String> getCookies() async {
    String cookie = '';

    try {
      final response = await dio.post(
        'https://auth.riotgames.com/api/v1/authorization',
        data: {
          'client_id': 'play-valorant-web-prod',
          'nonce': '1',
          'redirect_uri': 'https://playvalorant.com/opt_in',
          'response_type': 'token id_token',
          'scope': 'account openid',
        },
      );

      final List<String>? setCookie = response.headers['set-cookie'];
      if (setCookie != null) {
        cookie = setCookie.map((item) => item.split(';')[0]).join('; ');
      }
    } catch (e) {
      log('authCookie error: $e', name: 'authCookie error');
      rethrow;
    }

    return cookie;
  }

  Future<bool> getToken(String username, String password) async {
    try {
      final response = await dio.put(
        'https://auth.riotgames.com/api/v1/authorization',
        options: Options(headers: {
          'Cookie': await getCookies(),
        }),
        data: {
          'type': 'auth',
          'username': username,
          'password': password,
          'remember': false,
          'language': 'en_US',
        },
      );

      if (response.statusCode != 200) return false;
      //todo: implementar de funcion otp para la verficacion de doble factor
      // if (response.data['type'] == 'multifactor') {
      //   print('Multifactor authentication required');
      //   return true;
      // }
      final String url = response.data['response']['parameters']['uri'];
      // final uri = Uri.parse(url);
      final accessToken = extractAccessToken(url);
      // final accessToken = uri.queryParameters['access_token'];
      // final idToken = uri.queryParameters['id_token'] ?? '';

      // todo: implementar validacion y guardar los tokens
      // if (accessToken != null && idToken != null) {
      //   log('accessToken: $accessToken');
      //   log('idToken: $idToken');
      // }
      final token = await getEntitlement(accessToken);
      await getInfoPlayer(token);
    } catch (e) {
      log('Get token error: $e', name: 'getToken error');
      return false;
    }

    return false;
  }

  String extractAccessToken(String url) {
    // Parse the URL
    final Uri uri = Uri.parse(url);

    // Extract the fragment part of the URL (everything after #)
    final String fragment = uri.fragment;

    // Use a regular expression to find the value of access_token
    final RegExp regExp = RegExp(r'access_token=([^&]*)');
    final Match? match = regExp.firstMatch(fragment);

    // Check if we found a match
    if (match != null && match.groupCount >= 1) {
      return match.group(1)!; // Return the access token
    } else {
      return 'No access_token found';
    }
  }

  // Future<void> cookieReauth() async {
  //   print('cookieReauth');

  //   final ssid = await secureStorage.read(key: 'ssid');

  //   try {
  //     await dio.get(
  //       'https://auth.riotgames.com/authorize',
  //       options: Options(headers: {
  //         'Cookie': ssid,
  //       }),
  //       queryParameters: {
  //         'client_id': 'play-valorant-web-prod',
  //         'nonce': '1',
  //         'redirect_uri': 'https://playvalorant.com/opt_in',
  //         'response_type': 'token id_token',
  //         'scope': 'account openid',
  //       },
  //     );
  //   } catch (e) {
  //     final uri = Uri.parse(e.response?.requestOptions.uri.toString());
  //     final accessToken = uri.queryParameters['access_token'];
  //     final idToken = uri.queryParameters['id_token'];

  //     if (accessToken != null && idToken != null) {
  //       secureStorage.write(key: 'access_token', value: accessToken);
  //       secureStorage.write(key: 'id_token', value: idToken);
  //     } else {
  //       print('cookie reauth error: $e');
  //       rethrow;
  //     }
  //   }
  // }

  Future<String> getEntitlement(String accessToken) async {
    log('getEntitlement');

    try {
      final response = await dio.post(
        'https://entitlements.auth.riotgames.com/api/token/v1',
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

      return entitlementsToken;
    } catch (e) {
      log('getEntitlement error: $e');
      rethrow;
    }
  }

  Future<void> getInfoPlayer(String token) async {
    log('getInfoPlayer');

    try {
      // dio.options.headers['content-type'] = null;
      final response = await dio.get(
        'https://auth.riotgames.com/userinfo',
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
      );

      log(response.data);
    } catch (e) {
      log('getEntitlement error: $e');
      rethrow;
    }
  }

  // Future<bool> multifactor(String code) async {
  //   final tdid = await secureStorage.read(key: 'tdid');
  //   final asid = await secureStorage.read(key: 'asid');
  //   final clid = await secureStorage.read(key: 'clid');

  //   try {
  //     final response = await dio.put(
  //       'https://auth.riotgames.com/api/v1/authorization',
  //       options: Options(headers: {
  //         'Content-Type': 'application/json',
  //         'Cookie': '$tdid;$asid;$clid',
  //       }),
  //       data: {
  //         'type': 'multifactor',
  //         'code': code,
  //         'rememberDevice': true,
  //       },
  //     );

  //     final uri = Uri.parse(response.data['response']['parameters']['uri']);
  //     final accessToken = uri.queryParameters['access_token'];

  //     if (accessToken != null) {
  //       await secureStorage.write(key: 'access_token', value: accessToken);
  //       return true;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }

  //   return false;
  // }

  Future<void> logout() async {
    try {
      final response = await dio.post(
        'https://auth.riotgames.com/api/v1/authorization',
        data: {
          'client_id': 'play-valorant-web-prod',
          'nonce': '1',
          'redirect_uri': 'https://playvalorant.com/opt_in',
          'response_type': 'token id_token',
          'scope': 'account openid',
        },
      );

      log('logout');
    } catch (e) {
      log('logout error: $e', name: 'logout error');
    }
  }
}
