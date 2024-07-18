// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:double_tap/app/data/models/party.dart';
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
  Future<PartyResponsePriv> getParty() {
    // TODO: implement getParty
    throw UnimplementedError();
  }

  @override
  Future<PartyPlayerResponse?> getPartyPlayer() {
    // TODO: implement getPartyPlayer
    throw UnimplementedError();
  }

  @override
  Future<WalletResponse> wallet() {
    return datasource.wallet();
  }
}
