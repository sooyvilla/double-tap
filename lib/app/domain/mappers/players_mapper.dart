import 'package:double_tap/app/config/config.dart';
import 'package:double_tap/app/data/models/user_v1.dart';
import 'package:double_tap/app/domain/entities/valorant_user.dart';

Future<ValorantUser> mapPlayer(UserV1 user) async {
  final storage = SecureStorageConfig();
  final region = await storage.readData(KeysAuth.region);
  final puuid = await storage.readData(KeysAuth.puuid);
  return ValorantUser(
    country: user.country,
    region: region,
    username: user.acct?.gameName,
    tagLine: user.acct?.tagLine,
    card: Card(
      id: user.identity?.playerCardID,
      small: UrlImage.urlCardSmall(user.identity!.playerCardID!),
      wide: UrlImage.urlCardWide(user.identity!.playerCardID!),
      large: UrlImage.urlCardLarge(user.identity!.playerCardID!),
    ),
    puuid: puuid,
    levelAccount: user.identity!.accountLevel.toString(),
    playerTitle: user.identity!.playerTitleID,
  );
}
