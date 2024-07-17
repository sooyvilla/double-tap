import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:double_tap/app/data/models/party.dart';
import 'package:double_tap/app/data/models/wallet_response.dart';
import 'package:double_tap/app/data/utils/headers.dart';

import '../../config/config.dart';
import '../../domain/datasource/valorant_live_datasource.dart';
import '../models/store_user.dart';

class ValorantApiLiveDatasource extends ValorantLiveDatasource
    with DioConfigService {
  final _prefs = SharedPreferencesConfig.prefs;

  @override
  Future<PartyResponsePriv> getParty() async {
    final region = _prefs?.getString(KeysAuth.region) ?? '';
    final shard = _prefs?.getString(KeysAuth.shard) ?? '';
    try {
      final party = await getPartyPlayer();
      final response = await dio.get(
          '${ValorantUrls.urlBaseParty(region, shard)}parties/${party!.requests[0].partyID}',
          options: Options(headers: getHeaders()));

      return PartyResponsePriv.fromJson(response.data);
    } catch (e) {
      log('getParty error: $e', name: 'getParty error');
      rethrow;
    }
  }

  @override
  Future<PartyPlayerResponse?> getPartyPlayer() async {
    final region = _prefs?.getString(KeysAuth.region) ?? '';
    final shard = _prefs?.getString(KeysAuth.shard) ?? '';
    final puuid = _prefs?.getString(KeysAuth.puuid) ?? '';
    try {
      final response = await dio.get(
        '${ValorantUrls.urlBaseParty(region, shard)}players/$puuid',
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

  @override
  Future<StoreUser> getStore() async {
    final shard = _prefs?.getString(KeysAuth.shard) ?? '';
    final puuid = _prefs?.getString(KeysAuth.puuid) ?? '';

    try {
      final response = await dio.get(ValorantUrls.urlStore(shard, puuid),
          options: Options(
            headers: getHeaders(),
          ));
      if (response.statusCode == 200) {
        final storeUser = StoreUser.fromJson(response.data);
        return storeUser;
      }
      throw Exception('No store found');
    } catch (e) {
      log('getStore error: $e', name: 'getStore error');
      rethrow;
    }
  }

  @override
  Future<WalletResponse> wallet() async {
    final shard = _prefs?.getString(KeysAuth.shard) ?? '';
    final puuid = _prefs?.getString(KeysAuth.puuid) ?? '';
    try {
      final response = await dio.get(
          '${ValorantUrls.urlBaseStore(shard)}/wallet/$puuid',
          options: Options(headers: getHeaders()));

      return WalletResponse.fromJson(response.data);
    } catch (e) {
      log('wallet error: $e', name: 'wallet error');
      rethrow;
    }
  }
}
