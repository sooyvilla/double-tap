import 'package:isar/isar.dart';

part 'account.g.dart';

@collection
class Account {
  Id? isarId;

  final String idUsername;
  final String showName;
  final String tagLine;
  final String idPassword;
  bool isLoggedIn;

  Account({
    required this.idUsername,
    required this.showName,
    required this.tagLine,
    required this.idPassword,
    required this.isLoggedIn,
  });
}
