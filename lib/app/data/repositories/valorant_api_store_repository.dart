import 'package:double_tap/app/data/models/store_user.dart';

import '../../domain/datasource/valorant_store_datasource.dart';
import '../../domain/repositories/valorant_store_repository.dart';

 class ValorantApiStoreRepository  extends ValorantStoreRepository {
  final ValorantStoreDatasource datasource;

  ValorantApiStoreRepository(this.datasource);
  @override
  Future<StoreUser> getStore() {
    return datasource.getStore();
  }
}
