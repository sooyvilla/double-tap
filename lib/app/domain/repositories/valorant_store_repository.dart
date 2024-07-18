import '../../data/models/store_user.dart';

abstract class ValorantStoreRepository {
  Future<StoreUser> getStore();
}