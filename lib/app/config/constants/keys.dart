class KeysAuth {
  static const String cookie = 'cookie';
  static const String accessToken = 'access_token';
  static const String idToken = 'id_token';
  static const String entitlementsToken = 'entitlements_token';
  static const String versionApi = 'version_api';
  static const String ssid = 'ssid';
  static const String puuid = 'puuid';

  static List<String> get allKeys => [
        cookie,
        accessToken,
        idToken,
        entitlementsToken,
        versionApi,
        ssid,
        puuid,
      ];
}
