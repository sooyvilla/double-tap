import 'package:double_tap/app/data/models/store_user.dart';
import 'package:double_tap/app/data/models/wallet_response.dart';

import '../../domain/repositories/valorant_live_repository.dart';
import '../datasource/valorant_api_live_datasource.dart';

class ValorantApiLiveRepository extends ValorantLiveRepository {
  final ValorantApiLiveDatasource datasource;
  ValorantApiLiveRepository(this.datasource);

  @override
  Future<StoreUser> getStore() {
    return datasource.getStore();
  }

  @override
  Future<WalletResponse> wallet() {
    return datasource.wallet();
  }
}
