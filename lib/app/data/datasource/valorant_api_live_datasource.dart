import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:double_tap/app/data/models/party.dart';
import 'package:double_tap/app/data/utils/headers.dart';

import '../../config/config.dart';
import '../../domain/datasource/valorant_live_datasource.dart';

class ValorantApiLiveDatasource extends ValorantLiveDatasource
    with DioConfigService {
  final _prefs = SharedPreferencesConfig.prefs;

  Future<PartyResponse> getParty() async {
    final region = _prefs?.getString(KeysAuth.region) ?? '';
    final shard = _prefs?.getString(KeysAuth.shard) ?? '';
    try {
      final party = await getPartyPlayer();
      final response = await dio.get(ValorantUrls.urlBaseParty(region, shard) +
          'parties/${party!.requests[0].partyID}');

      return PartyResponse.fromJson(response.data);
    } catch (e) {
      log('getParty error: $e', name: 'getParty error');
      rethrow;
    }
  }

  Future<PartyPlayerResponse?> getPartyPlayer() async {
    final region = _prefs?.getString(KeysAuth.region) ?? '';
    final shard = _prefs?.getString(KeysAuth.shard) ?? '';
    final puuid = _prefs?.getString(KeysAuth.puuid) ?? '';
    try {
      final response = await dio.get(
        ValorantUrls.urlBaseParty(region, shard) + 'players/$puuid',
        options: Options(headers: getHeaders()),
      );

      if (response.statusCode == 200) {
        final partyPlayer = PartyPlayerResponse.fromJson(response.data);
        return partyPlayer;
      }
      return null;
    } catch (e) {
      log('getPartyPlayer error: $e', name: 'getPartyPlayer error');
      rethrow;
    }
  }
}
