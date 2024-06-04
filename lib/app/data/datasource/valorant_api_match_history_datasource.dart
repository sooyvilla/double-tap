import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:insane_bolt/app/config/constants/constants.dart';

import '../../config/config.dart';
import '../../domain/datasource/valorant_match_history_datasource.dart';
import '../../domain/models/match_history.dart';

class ValorantApiMatchHistoryDatasource extends ValorantMatchHistoryDatasource
    with DioConfigService {
  final _clientPlatform =
      'ew0KCSJwbGF0Zm9ybVR5cGUiOiAiUEMiLA0KCSJwbGF0Zm9ybU9TIjogIldpbmRvd3MiLA0KCSJwbGF0Zm9ybU9TVmVyc2lvbiI6ICIxMC4wLjE5MDQyLjEuMjU2LjY0Yml0IiwNCgkicGxhdGZvcm1DaGlwc2V0IjogIlVua25vd24iDQp9';

  Future<void> getMatchHistory() async {
    final prefs = SharedPreferencesConfig.prefs;

    final puuid = prefs?.getString(KeysAuth.puuid) ?? '';
    final verrsionApi = prefs?.getString(KeysAuth.versionApi) ?? '';
    final entitlementsToken =
        prefs?.getString(KeysAuth.entitlementsToken) ?? '';
    final accessToken = prefs?.getString(KeysAuth.accessToken) ?? '';
    try {
      final response = await dio.get(
        ValorantUrls.urlMatch('na', puuid),
        options: Options(headers: {
          'X-Riot-ClientPlatform': _clientPlatform,
          'X-Riot-ClientVersion': verrsionApi,
          'X-Riot-Entitlements-JWT': entitlementsToken,
          'Authorization': 'Bearer $accessToken',
        }),
      );

      log(response.data.runtimeType.toString(), name: 'getMatchHistory');

      final match = MatchHistory.fromJson(
          jsonDecode(response.data) as Map<String, dynamic>);

    } catch (e) {
      log('getMatchHistory error: $e', name: 'getMatchHistory error');
      rethrow;
    }
  }
}
