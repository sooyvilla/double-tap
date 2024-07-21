import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:double_tap/app/data/models/wallet_response.dart';
import 'package:double_tap/app/data/utils/headers.dart';

import '../../config/config.dart';
import '../../domain/datasource/valorant_live_datasource.dart';
import '../models/store_user.dart';

class ValorantApiLiveDatasource extends ValorantLiveDatasource
    with DioConfigService {
  final _prefs = SharedPreferencesConfig.prefs;

  @override
  Future<StoreUser> getStore() async {
    final shard = _prefs?.getString(KeysAuth.shard) ?? '';
    final puuid = _prefs?.getString(KeysAuth.puuid) ?? '';

    try {
      final response = await dio.post(ValorantUrls.urlStore(shard, puuid),
          data: {},
          options: Options(
            headers: getHeaders(),
          ));
      if (response.statusCode == 200) {
        StoreUser storeUser = StoreUser.fromJson(response.data);
        final List<InfoItemStore> itemsStore = [];
        final List<BundleInfo> bundles = [];
        for (var item in storeUser.skinsPanelLayout!.singleItemStoreOffers!) {
          final responseSingleItem = await dio.get(
              'https://valorant-api.com/v1/weapons/skinlevels/${item.rewards![0].itemId}');
          itemsStore.add(InfoItemStore.fromJson(responseSingleItem.data));
        }
        for (var item in storeUser.featuredBundle!.bundles!) {
          final responseSingleBundle = await dio
              .get('https://valorant-api.com/v1/bundles/${item.dataAssetId}');
          bundles.add(BundleInfo.fromJson(responseSingleBundle.data));
        }
        storeUser =
            storeUser.copyWith(infoItemStore: itemsStore, bundleInfo: bundles);
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
          '${ValorantUrls.urlBaseStore(shard)}wallet/$puuid',
          options: Options(headers: getHeaders()));

      return WalletResponse.fromJson(response.data);
    } catch (e) {
      log('wallet error: $e', name: 'wallet error');
      rethrow;
    }
  }
}
