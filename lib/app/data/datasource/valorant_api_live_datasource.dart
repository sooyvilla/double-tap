import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:double_tap/app/data/models/wallet_response.dart';
import 'package:double_tap/app/data/models/weapons.dart';
import 'package:double_tap/app/data/utils/headers.dart';

import '../../config/config.dart';
import '../../domain/datasource/valorant_live_datasource.dart';
import '../models/store_user.dart';

class ValorantApiLiveDatasource extends ValorantLiveDatasource
    with DioConfigService {
  final _storage = SecureStorageConfig();

  WeaponsSkins? allSkinsInfo;

  @override
  Future<StoreUser> getStore() async {
    final shard = await _storage.readData(KeysAuth.shard) ?? '';
    final puuid = await _storage.readData(KeysAuth.puuid) ?? '';

    try {
      final response = await dio.post(ValorantUrls.urlStore(shard, puuid),
          data: {},
          options: Options(
            headers: await getHeaders(),
          ));
      if (response.statusCode == 200) {
        StoreUser storeUser = StoreUser.fromJson(response.data);
        final List<Weapon> itemsStore = [];
        final List<BundleInfo> bundles = [];
        final List<Weapon> bundlesWeapons = [];
        for (var item in storeUser.skinsPanelLayout!.singleItemStoreOffers!) {
          final idWeaponMaxLevel = await getMaxLevelWeapon(item.offerId!);
          itemsStore.add(idWeaponMaxLevel!);
        }
        for (var item in storeUser.featuredBundle!.bundles!) {
          final responseSingleBundle = await dio
              .get('https://valorant-api.com/v1/bundles/${item.dataAssetId}');
          for (var weapon in item.items!) {
            final idWeaponMaxLevel =
                await getMaxLevelWeapon(weapon.item!.itemId!);
            if (idWeaponMaxLevel == null) continue;
            bundlesWeapons.add(idWeaponMaxLevel);
          }
          bundles.add(BundleInfo.fromJson(responseSingleBundle.data));
        }
        if (itemsStore.isNotEmpty) {
          storeUser = storeUser.copyWith(infoItemStore: itemsStore);
        }
        if (bundles.isNotEmpty) {
          storeUser = storeUser.copyWith(bundleInfo: bundles);
        }
        if (bundlesWeapons.isNotEmpty) {
          storeUser = storeUser.copyWith(bundleItems: bundlesWeapons);
        }
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
    final shard = await _storage.readData(KeysAuth.shard) ?? '';
    final puuid = await _storage.readData(KeysAuth.puuid) ?? '';
    try {
      final response = await dio.get(
          '${ValorantUrls.urlBaseStore(shard)}wallet/$puuid',
          options: Options(headers: await getHeaders()));

      return WalletResponse.fromJson(response.data);
    } catch (e) {
      log('wallet error: $e', name: 'wallet error');
      rethrow;
    }
  }

  Future<Weapon?> getMaxLevelWeapon(String id) async {
    try {
      if (allSkinsInfo == null) {
        final response =
            await dio.get('https://valorant-api.com/v1/weapons/skins');
        if (response.statusCode != 200) throw Exception('Server error');
        allSkinsInfo = WeaponsSkins.fromJson(response.data);
      }

      if (allSkinsInfo!.data!.isEmpty) throw Exception('No have weapons found');

      for (var weapon in allSkinsInfo!.data!) {
        final Level? level = weapon.levels
            ?.firstWhere((level) => level.uuid == id, orElse: () => Level());
        if (level!.uuid != null) {
          return weapon;
        }
      }
      return null;
    } catch (e) {
      log('getWeaponWithLevelId error: $e', name: 'getWeaponWithLevelId error');
      rethrow;
    }
  }
}
