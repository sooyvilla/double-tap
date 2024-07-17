import 'package:double_tap/app/data/models/store_user.dart';
import 'package:double_tap/app/data/models/wallet_response.dart';

import '../../data/models/party.dart';

abstract class ValorantLiveRepository {
  Future<PartyResponsePriv> getParty();
  Future<PartyPlayerResponse?> getPartyPlayer();
  Future<StoreUser> getStore();
  Future<WalletResponse> wallet();
}
