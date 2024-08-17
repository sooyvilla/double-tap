import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:double_tap/app/data/models/wallet_response.dart';
import 'package:double_tap/app/data/utils/headers.dart';

import '../../config/config.dart';
import '../../domain/datasource/valorant_live_datasource.dart';
import '../models/store_user.dart';

class ValorantApiLiveDatasource extends ValorantLiveDatasource
    with DioConfigService {
  final _storage = SecureStorageConfig();

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
        return StoreUser.fromJson(response.data);
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
}
