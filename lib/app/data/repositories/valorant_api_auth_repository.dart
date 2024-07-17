import 'package:double_tap/app/data/models/user_v1.dart';

import '../../domain/datasource/valorant_auth_datasource.dart';
import '../../domain/repositories/valorant_auth_repository.dart';

class ValorantApiAuthRepository extends ValorantAuthRepository {
  final ValorantAuthDatasource datasource;

  ValorantApiAuthRepository(this.datasource);

  @override
  Future<UserV1> getInfoPlayer() {
    return datasource.getInfoPlayer();
  }

  @override
  Future<void> reauthentication() {
    return datasource.reauthentication();
  }

  @override
  Future<bool> login(String username, String password) {
    return datasource.login(username, password);
  }

  @override
  Future<void> loginWebView(String url) {
    return datasource.loginWebView(url);
  }
}
