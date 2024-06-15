import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:double_tap/app/config/constants/constants.dart';
import 'package:double_tap/app/data/utils/headers.dart';

import '../../config/config.dart';
import '../../domain/datasource/valorant_match_history_datasource.dart';
import '../models/match_history.dart';

class ValorantApiMatchHistoryDatasource extends ValorantMatchHistoryDatasource
    with DioConfigService {
  final _prefs = SharedPreferencesConfig.prefs;
  Future<void> getMatchHistory() async {
    final puuid = _prefs?.getString(KeysAuth.puuid) ?? '';
    final shard = _prefs?.getString(KeysAuth.shard) ?? '';
    try {
      final response = await dio.get(
        ValorantUrls.urlMatch(shard, puuid),
        options: Options(headers: getHeaders()),
      );

      log(response.data.toString(), name: 'getMatchHistory');

      final match = MatchHistory.fromJson(
          jsonDecode(response.data) as Map<String, dynamic>);

      match;
    } catch (e) {
      log('getMatchHistory error: $e', name: 'getMatchHistory error');
      rethrow;
    }
  }
}
