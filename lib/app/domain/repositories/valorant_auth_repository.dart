import 'package:double_tap/app/data/models/user_v1.dart';

abstract class ValorantAuthRepository {
  Future<bool> login(String username, String password);
  Future<void> loginWebView(String url);
  Future<UserV1> getInfoPlayer();
  Future<void> reauthentication();
}
