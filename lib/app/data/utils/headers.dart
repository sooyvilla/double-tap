import 'dart:developer';

import '../../config/config.dart';

Future<Map<String, String>> getHeaders() async {
  final headers = <String, String>{};
  final storage = SecureStorageConfig();
  try {
    final accessToken = await storage.readData(KeysAuth.accessToken);
    final versionApi = await storage.readData(KeysAuth.versionApi);
    final entitlementsToken = await storage.readData(KeysAuth.entitlementsToken);
    headers['X-Riot-ClientPlatform'] = ValorantUrls.clientPlatform;
    headers['X-Riot-ClientVersion'] = versionApi!;
    headers['X-Riot-Entitlements-JWT'] = entitlementsToken!;
    headers['Authorization'] = 'Bearer $accessToken';
    return headers;
  } catch (e) {
    log('getHeaders error: $e', name: 'getHeaders error');
    rethrow;
  }
}
