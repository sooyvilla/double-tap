import 'package:double_tap/app/data/models/user_v1.dart';

abstract class ValorantAuthDatasource {
  Future<bool> login(String username, String password);
  Future<void> loginWebView(String url);
  Future<UserV1> getInfoPlayer();
  Future<void> validateToken();
}
