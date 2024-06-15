class ValorantUrls {
  static const String urlAuth =
      'https://auth.riotgames.com/api/v1/authorization';
  static const String urlMultifactor =
      'https://auth.riotgames.com/api/v2/authorization';
  static const String urlEntitlement =
      'https://entitlements.auth.riotgames.com/api/token/v1';
  static const String urlCookieReAuth =
      'https://auth.riotgames.com/authorize?redirect_uri=https%3A%2F%2Fplayvalorant.com%2Fopt_in&client_id=play-valorant-web-prod&response_type=token%20id_token&nonce=1&scope=account%20openid';
  static const String urlUserInfo = 'https://auth.riotgames.com/userinfo';
  static const String urlVersionApi = 'https://valorant-api.com/v1/version';
  static const clientPlatform =
      'ew0KCSJwbGF0Zm9ybVR5cGUiOiAiUEMiLA0KCSJwbGF0Zm9ybU9TIjogIldpbmRvd3MiLA0KCSJwbGF0Zm9ybU9TVmVyc2lvbiI6ICIxMC4wLjE5MDQyLjEuMjU2LjY0Yml0IiwNCgkicGxhdGZvcm1DaGlwc2V0IjogIlVua25vd24iDQp9';
  static const String urlLoginWebView =
      'https://auth.riotgames.com/authorize?redirect_uri=https%3A%2F%2Fplayvalorant.com%2Fopt_in&client_id=play-valorant-web-prod&response_type=token%20id_token&nonce=1&scope=account%20openid';
  static urlBaseParty(String region, String shard) =>
      'https://glz-$region-1.$shard.a.pvp.net/parties/v1/';
  static set urlBaseStore(String shard) =>
      'https://pd.$shard.a.pvp.net/store/v1/';
  static urlMatch(String shard, String puuid) =>
      'https://pd.$shard.a.pvp.net/match-history/v1/history/$puuid';
  static urlPersonalization(String shard, String puuid) =>
      'https://pd.$shard.a.pvp.net/personalization/v2/players/$puuid/playerloadout';
}
