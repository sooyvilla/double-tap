import 'package:double_tap/app/domain/entities/account.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarInstance {
  late Future<Isar> db;

  IsarInstance() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();

    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([AccountSchema],
          inspector: true, directory: dir.path);
    }

    return Future.value(Isar.getInstance());
  }

  Future<Account> saveAccount(Account account) async {
    final isar = await db;

    final existingAccount = await isar.accounts
        .where()
        .filter()
        .showNameEqualTo(account.showName)
        .findFirst();

    if (existingAccount != null) {
      return existingAccount;
    }

    await isar.writeTxn(() async {
      await isar.accounts.put(account);
    });

    final newAccount = await isar.accounts
        .where()
        .filter()
        .showNameEqualTo(account.showName)
        .findFirst();

    return newAccount!;
  }

  Future<Account?> getAccount(Id id) async {
    final isar = await db;

    return await isar.accounts.get(id);
  }

  Future<List<Account>> getAllAccounts() async {
    final isar = await db;

    return isar.accounts.where().sortByIsLoggedIn().findAll();
  }

  Future<void> updateAccount(Account account) async {
    final isar = await db;

    isar.writeTxnSync(() => isar.accounts.putSync(account));
  }

  Future<void> deleteAccount(Id id) async {
    final isar = await db;

    isar.writeTxnSync(() => isar.accounts.deleteSync(id));
  }

  Future<void> deleteAllAccounts(List<Id> ids) async {
    final isar = await db;

    isar.writeTxnSync(() => isar.accounts.deleteAllSync(ids));
  }

  Future<Account?> validateIfExists(Account account) async {
    final isar = await db;

    final existingAccount = await isar.accounts
        .where()
        .filter()
        .showNameEqualTo(account.showName)
        .findFirst();

    return existingAccount;
  }
}
