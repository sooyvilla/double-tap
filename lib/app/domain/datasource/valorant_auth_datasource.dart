import 'package:insane_bolt/app/domain/models/user_v1.dart';

abstract class ValorantAuthDatasource {
  Future<bool> login(String username, String password);
  Future<void> loginWebView(String token);
  Future<UserV1> getInfoPlayer();
  Future<void> reauthentication();
}
