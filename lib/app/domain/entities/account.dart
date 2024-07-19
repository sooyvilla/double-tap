import 'package:isar/isar.dart';

part 'account.g.dart';

@collection
class Account {
  Id? isarId;

  final String username;
  final String showName;
  final String tagLine;
  final String password;
  bool isLoggedIn;

  Account({
    required this.username,
    required this.showName,
    required this.tagLine,
    required this.password,
    required this.isLoggedIn,
  });
}
