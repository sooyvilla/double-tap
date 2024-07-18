import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:double_tap/app/data/models/store_user.dart';
import 'package:double_tap/app/data/utils/headers.dart';

import '../../config/config.dart';
import '../../domain/datasource/valorant_store_datasource.dart';

class ValorantApiStoreDatasource extends ValorantStoreDatasource
    with DioConfigService {
  final _prefs = SharedPreferencesConfig.prefs;
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
}
