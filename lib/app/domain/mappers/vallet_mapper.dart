import 'package:double_tap/app/data/models/wallet_response.dart';
import 'package:double_tap/app/domain/entities/wallet.dart';

Wallet mapVallet(WalletResponse wallet) {
  final moneyList = wallet.toMap().entries.map((e) => e.value).toList();
  return Wallet(
    valorantPoints: moneyList[0],
    money: moneyList[1],
    radianitePoints: moneyList[2],
  );
}
