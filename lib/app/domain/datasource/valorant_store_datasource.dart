import '../../data/models/store_user.dart';

abstract class ValorantStoreDatasource {
  Future<StoreUser> getStore();
}
