import 'dart:developer';

import 'package:double_tap/app/config/config.dart';

import '../../data/models/store_user.dart';
import '../../data/models/weapons.dart';
import '../entities/store.dart';

class StoreMapper {
  static final _dio = DioImplement().dioImp;
  static WeaponsSkins? _allSkinsInfo;

  static Future<Store> mapper(StoreUser storeUser) async {
    final storeWeapons =
        storeUser.skinsPanelLayout!.singleItemStoreOffers!.map((e) async {
      final weapon = await _getWeaponInfo(e.offerId!, 'e.rewards![0].itemId!');
      final displayIcon = weapon?.displayIcon ??
          weapon?.levels
              ?.firstWhere(
                (level) => level.uuid == e.offerId,
                orElse: () => Level(),
              )
              .displayIcon;
      final displayVideo = weapon?.levels?.last.streamedVideo ??
          weapon?.levels?.reversed
              .firstWhere(
                (level) => level.streamedVideo != null,
                orElse: () => Level(),
              )
              .streamedVideo;
      final name = weapon?.displayName ??
          weapon?.levels
              ?.firstWhere(
                (level) => level.uuid == e.offerId,
                orElse: () => Level(),
              )
              .displayName;
      return WeaponSingle(
        name: name ?? '',
        typeId: e.rewards?.first.itemTypeId ?? '',
        id: e.offerId ?? '',
        price: e.cost?.cost ?? 0,
        displayIcon: displayIcon,
        discount: null,
        displayVideo: displayVideo,
      );
    }).toList();
    final packs = storeUser.featuredBundle!.bundles?.map((e) async {
      final pack = await _getBundle(e.dataAssetId!);
      final weapons = e.itemOffers?.map((e) async {
        if (getTypeItem(e.offer!.rewards!.first.itemTypeId!) ==
            TypeItemName.skins) {
          final weapon =
              await _getWeaponInfo(e.offer!.offerId!, 'e.rewards![0].itemId!');
          final displayIcon = weapon?.displayIcon ??
              weapon?.levels
                  ?.firstWhere(
                    (level) => level.uuid == e.offer!.offerId!,
                    orElse: () => Level(),
                  )
                  .displayIcon;
          final displayVideo = weapon?.levels?.last.streamedVideo ??
              weapon?.levels?.reversed
                  .firstWhere(
                    (level) => level.streamedVideo != null,
                    orElse: () => Level(),
                  )
                  .streamedVideo;
          final name = weapon?.displayName ??
              weapon?.levels
                  ?.firstWhere(
                    (level) => level.uuid == e.offer!.offerId!,
                    orElse: () => Level(),
                  )
                  .displayName;
          return WeaponSingle(
            name: name ?? '',
            typeId: e.offer!.rewards?.first.itemTypeId ?? '',
            id: e.offer!.offerId ?? '',
            price: e.offer!.cost?.cost ?? 0,
            displayIcon: displayIcon,
            displayVideo: displayVideo,
          );
        }
      });
      final listWeaponPack = await Future.wait(weapons!);
      return Packs(
        name: pack?.data?.displayName ?? '',
        id: pack?.data?.uuid ?? '',
        price: e.totalDiscountedCost!.cost!,
        discount: e.totalDiscountPercent!,
        displayIcon: pack?.data?.displayIcon ?? '',
        weapons: listWeaponPack.where((e) => e != null).toList(),
        timePack: e.durationRemainingInSeconds ?? 0,
      );
    }).toList();
    final nightMarket = storeUser.bonusStore?.bonusStoreOffers?.map((el) async {
      final e = el.offer!;
      final weapon = await _getWeaponInfo(e.offerId!, 'e.rewards![0].itemId!');
      final displayIcon = weapon?.displayIcon ??
          weapon?.levels
              ?.firstWhere(
                (level) => level.uuid == e.offerId,
                orElse: () => Level(),
              )
              .displayIcon;
      final displayVideo = weapon?.levels?.last.streamedVideo ??
          weapon?.levels?.reversed
              .firstWhere(
                (level) => level.streamedVideo != null,
                orElse: () => Level(),
              )
              .streamedVideo;
      final name = weapon?.displayName ??
          weapon?.levels
              ?.firstWhere(
                (level) => level.uuid == e.offerId,
                orElse: () => Level(),
              )
              .displayName;
      return WeaponSingle(
        name: name ?? '',
        typeId: e.rewards?.first.itemTypeId ?? '',
        id: e.offerId ?? '',
        price: e.cost?.cost ?? 0,
        displayIcon: displayIcon,
        discount: null,
        displayVideo: displayVideo,
      );
    }).toList();
    _allSkinsInfo = null;
    return Store(
      timeStore: storeUser
          .skinsPanelLayout!.singleItemOffersRemainingDurationInSeconds!,
      store: await Future.wait(storeWeapons),
      packs: await Future.wait(packs!),
      nightMarket: await Future.wait(nightMarket?.toList() ?? []),
    );
  }

  static Future<String?> _getDisplayIcon(String id, String itemId) async {
    try {
      if (_allSkinsInfo == null) {
        final response =
            await _dio.get('https://valorant-api.com/v1/weapons/skins');
        if (response.statusCode != 200) throw Exception('Server error');
        _allSkinsInfo = WeaponsSkins.fromJson(response.data);
      }

      if (_allSkinsInfo!.data!.isEmpty) {
        throw Exception('No have weapons found');
      }

      for (var weapon in _allSkinsInfo!.data!) {
        final Level? level = weapon.levels
            ?.firstWhere((level) => level.uuid == id, orElse: () => Level());
        if (level!.uuid != null) {
          return weapon.levels!.map((e) {
            if (weapon.displayIcon != null) {
              return weapon.displayIcon;
            }
            if (e.displayIcon != null) {
              return e.displayIcon;
            }
          }).toString();
        }
      }
      return null;
    } catch (e) {
      log('mapper store error: $e', name: 'Mapper Store');
      rethrow;
    }
  }

  static Future<BundleInfo?> _getBundle(String id) async {
    try {
      final response =
          await _dio.get('https://valorant-api.com/v1/bundles/$id');
      if (response.statusCode != 200) throw Exception('Server error');
      return BundleInfo.fromJson(response.data);
    } catch (e) {
      log('getBundle error: $e', name: 'getBundle error');
      rethrow;
    }
  }

  static Future<Weapon?> _getWeaponInfo(String id, String itemId) async {
    try {
      if (_allSkinsInfo == null) {
        final response =
            await _dio.get('https://valorant-api.com/v1/weapons/skins');
        if (response.statusCode != 200) throw Exception('Server error');
        _allSkinsInfo = WeaponsSkins.fromJson(response.data);
      }

      if (_allSkinsInfo!.data!.isEmpty) {
        throw Exception('No have weapons found');
      }

      for (var weapon in _allSkinsInfo!.data!) {
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

  static TypeItemName getTypeItem(String typeId) {
    final invertedTypeItem = typeItem.map((key, value) => MapEntry(value, key));
    final typeItemName = invertedTypeItem[typeId];
    switch (typeItemName) {
      case 'agents':
        return TypeItemName.agents;
      case 'contracts':
        return TypeItemName.contracts;
      case 'sprays':
        return TypeItemName.sprays;
      case 'gun_buddies':
        return TypeItemName.gun_buddies;
      case 'cards':
        return TypeItemName.cards;
      case 'skins':
        return TypeItemName.skins;
      case 'skin_variants':
        return TypeItemName.skin_variants;
      case 'titles':
        return TypeItemName.titles;
      default:
        return TypeItemName.no_found;
    }
  }
}

enum TypeItemName {
  agents,
  contracts,
  sprays,
  gun_buddies,
  cards,
  skins,
  skin_variants,
  titles,
  no_found,
}

const typeItem = <String, String>{
  'agents': '01bb38e1-da47-4e6a-9b3d-945fe4655707',
  'contracts': 'f85cb6f7-33e5-4dc8-b609-ec7212301948',
  'sprays': 'd5f120f8-ff8c-4aac-92ea-f2b5acbe9475',
  'gun_buddies': 'dd3bf334-87f3-40bd-b043-682a57a8dc3a',
  'cards': '3f296c07-64c3-494c-923b-fe692a4fa1bd',
  'skins': 'e7c63390-eda7-46e0-bb7a-a6abdacd2433',
  'skin_variants': '3ad1b2b2-acdb-4524-852f-954a76ddae0a',
  'titles': 'de7caa6b-adf7-4588-bbd1-143831e786c6',
};
