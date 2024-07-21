import 'package:double_tap/app/data/models/store_user.dart';
import 'package:double_tap/app/data/models/wallet_response.dart';

abstract class ValorantLiveDatasource {
  Future<StoreUser> getStore();
  Future<WalletResponse> wallet();
}
