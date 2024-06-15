import 'package:double_tap/app/config/config.dart';
import 'package:double_tap/app/data/models/user_v1.dart';
import 'package:double_tap/app/domain/entities/valorant_user.dart';

ValorantUser mapPlayer(UserV1 user) {
  final prefs = SharedPreferencesConfig.prefs;
  final region = prefs?.getString(KeysAuth.region);
  return ValorantUser(
    country: user.country,
    region: region,
    username: user.acct?.gameName,
    tagLine: user.acct?.tagLine,
    card: Card(
      id: user.identity?.playerCardID,
      small:
          'https://media.valorant-api.com/playercards/${user.identity?.playerCardID}/smallart.png',
      wide:
          'https://media.valorant-api.com/playercards/${user.identity?.playerCardID}/wideart.png',
      large:
          'https://media.valorant-api.com/playercards/${user.identity?.playerCardID}/largeart.png',
    ),
  );
}
