import 'dart:developer';

import '../../config/config.dart';

Map<String, String> getHeaders() {
  final headers = <String, String>{};
  final prefs = SharedPreferencesConfig.prefs;
  try {
    final accessToken = prefs?.getString(KeysAuth.accessToken);
    final versionApi = prefs?.getString(KeysAuth.versionApi);
    final entitlementsToken = prefs?.getString(KeysAuth.entitlementsToken);
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
