import 'dart:developer';

import 'package:double_tap/app/config/config.dart';
import 'package:double_tap/app/domain/entities/valorant_user.dart';
import 'package:double_tap/app/ui/providers/providers.dart';
import 'package:double_tap/app/ui/providers/settings/settings_provider_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';

import '../../../config/isar/isar_instance.dart';
import '../../../data/repositories/valorant_api_auth_repository.dart';
import '../../../domain/entities/account.dart';
import '../../../domain/mappers/players_mapper.dart';

final settingsAccountProvider =
    StateNotifierProvider<AccountNotifier, SettingsAccountState>((ref) {
  final datasource = ref.watch(settingsProviderImp);
  return AccountNotifier(
    datasource: datasource,
    ref: ref,
  );
});

final settingsCheckerProvider =
    StateNotifierProvider<CheckerNotifier, SettingsCheckerState>((ref) {
  return CheckerNotifier();
});

class AccountNotifier extends StateNotifier<SettingsAccountState> {
  AccountNotifier({
    required this.datasource,
    required this.ref,
  }) : super(SettingsAccountState());

  final ValorantApiAuthRepository datasource;
  final StateNotifierProviderRef<AccountNotifier, SettingsAccountState> ref;

  final _storage = SecureStorageConfig();

  Future<void> login() async {
    setIsLoading(true);

    try {
      final response = await datasource.login(state.username!, state.password!);

      if (!response) {
        setDoubleFactor(true);
        return;
      }
      await setUser();
      await saveAccount();
      await getAllAccounts();

      ref.read(liveProvider.notifier).cleanAll();
      await ref.read(liveProvider.notifier).init();

      setIsLoggedIn(true);
    } catch (e) {
      log('login error: $e', name: 'login error provider');
    } finally {
      setIsLoading(false);
    }
  }

  Future<void> changeLoggedAccount(Id id, [bool logged = false]) async {
    final isar = IsarInstance();

    final oldAccount = await isar.getAccount(id);
    oldAccount!.isLoggedIn = logged;
    isar.updateAccount(oldAccount);
  }

  Future<void> addAccount() async {
    setIsLoading(true);

    final oldId = state.id;

    try {
      if (state.isLoggedIn) {
        await changeLoggedAccount(oldId!);
        setIsLoggedIn(false);
      }

      deleteAllKeys();

      await login();

      setIsLoggedIn(true);
    } catch (e) {
      log('addAccount error: $e', name: 'addAccount error provider');
      await logoutAll();
    } finally {
      setIsLoading(false);
    }
  }

  Future<void> validateSession() async {
    setIsLoading(true);

    final isar = IsarInstance();
    final accounts = await isar.getAllAccounts();

    if (accounts.isEmpty) {
      setIsLoading(false);
      setIsLoggedIn(false);
      return;
    }

    final accountLogged =
        accounts.where((element) => element.isLoggedIn).toList();

    try {
      if (accountLogged.isEmpty) {
        state = state.copyWith(accounts: accounts);
        return;
      }

      // final username = await _storage.readData(accountLogged.first.idUsername);
      // final password = await _storage.readData(accountLogged.first.idPassword);

      // state = state.copyWith(
      //   username: username,
      //   password: password,
      // );

      // await login();

      await datasource.validateToken();
      await getAllAccounts();
      await setUser();

      ref.read(liveProvider.notifier).cleanAll();
      await ref.read(liveProvider.notifier).init();

      setIsLoggedIn(true);
    } catch (e) {
      log('validateSession error: $e', name: 'validateSession error provider');
      deleteAllKeys();
      logout(accountLogged.first.isarId!);
      setShowAlertStatusSesion(true);
    } finally {
      setIsLoading(false);
    }
  }

  Future<void> getAllAccounts() async {
    final isar = IsarInstance();

    setIsLoading(true);

    if (state.accounts != null) {
      state = state.copyWith(accounts: null);
    }

    final accounts = await isar.getAllAccounts();

    state = state.copyWith(accounts: accounts.reversed.toList());

    setIsLoading(false);
  }

  Future<void> updateAllAccounts(Id id) async {
    final accounts = state.accounts!;
    final account =
        state.accounts!.where((element) => element.isarId == id).first;

    accounts.remove(account);

    state = state.copyWith(accounts: accounts);
  }

  Future<void> switchAccount(Id id) async {
    setIsLoading(true);

    final isar = IsarInstance();

    try {
      if (state.id != null && state.id != id) {
        await changeLoggedAccount(state.id!);
      }

      final account = await isar.getAccount(id);

      if (state.id == null || state.id != id) {
        final username = await _storage.readData(account!.idUsername);
        final password = await _storage.readData(account.idPassword);

        state = state.copyWith(
          username: username,
          password: password,
          isLoggedIn: false,
          id: null,
          user: null,
        );

        deleteAllKeys();

        await login();
      }
      setIsLoggedIn(true);

      await changeLoggedAccount(id, true);
      await getAllAccounts();
    } catch (e) {
      log('switchAccount error: $e', name: 'switchAccount error provider');
    }
    setIsLoading(false);
  }

  Future<void> loginWebView(String token) async {
    setIsLoading(true);

    try {
      await datasource.loginWebView(token);

      await setUser();
      await saveAccount();
      await getAllAccounts();

      ref.read(liveProvider.notifier).cleanAll();
      await ref.read(liveProvider.notifier).init();

      setIsLoggedIn(true);
    } catch (e) {
      log('loginWebView error: $e', name: 'loginWebView error provider');
    }
    setIsLoading(false);
  }

  Future<void> setUser() async {
    try {
      setIsLoading(true);
      final user = await datasource.getInfoPlayer();

      state = state.copyWith(user: await mapPlayer(user));

      setIsLoggedIn(true);
    } catch (e) {
      logoutAll();
    } finally {
      setIsLoading(false);
    }
  }

  Future<void> saveAccount() async {
    final isar = IsarInstance();
    // const uuid = Uuid();
    // final uuidUsername = uuid.v8();
    // final uuidPassword = uuid.v8();

    final accounts = await isar.getAllAccounts();

    if (accounts.isNotEmpty) {
      isar.deleteAccount(accounts.first.isarId!);
    }

    final newAccount = Account(
      idUsername: '',
      idPassword: '',
      showName: state.user!.username!,
      tagLine: state.user!.tagLine!,
      isLoggedIn: true,
    );

    // final validateAccount = await isar.validateIfExists(newAccount);

    // if (validateAccount != null) {
    //   setId(validateAccount.isarId!);
    //   return;
    // }

    // await _storage.writeData(uuidUsername, state.username!);
    // await _storage.writeData(uuidPassword, state.password!);

    setUsername(null);
    setPassword(null);

    final account = await isar.saveAccount(newAccount);

    setId(account.isarId!);
  }

  Future<void> activeNextAccount() async {
    final accounts = state.accounts;
    final account = accounts?.first;
    if (account == null) {
      logoutAll();
      return;
    }
    await switchAccount(account.isarId!);
  }

  Future<void> logout(Id id) async {
    setIsLoading(true);
    final isar = IsarInstance();

    try {
      if (id == state.id) {
        deleteAllKeys();
        cleanStateCurrentUser();
        await activeNextAccount();
      }
      isar.deleteAccount(id);
      await updateAllAccounts(id);
      setIsLoggedIn(state.isLoggedIn);
    } catch (e) {
      log('logout error: $e', name: 'logout error provider');
    } finally {
      setIsLoading(false);
    }
  }

  Future<void> logoutAndRemember(Id id) async {
    setIsLoading(true);

    try {
      if (id == state.id) {
        deleteAllKeys();
        cleanStateCurrentUser();
        setIsLoggedIn(false);
      }
      await changeLoggedAccount(id);
      await getAllAccounts();
      ref.read(liveProvider.notifier).cleanAll();
    } catch (e) {
      log('logoutAndRemember error: $e',
          name: 'logoutAndRemember error provider');
    } finally {
      setIsLoading(false);
    }
  }

  Future<void> logoutAll() async {
    final isar = IsarInstance();
    final accounts = state.accounts!;
    final List<Id> ids = [];
    for (var account in accounts) {
      ids.add(account.isarId!);
    }
    cleanStateCurrentUser();
    try {
      deleteAllKeys();
      await isar.deleteAllAccounts(ids);
      await getAllAccounts();
      ref.read(liveProvider.notifier).cleanAll();
      setIsLoggedIn(false);
    } catch (e) {
      log('logoutAll error: $e', name: 'logoutAll error provider');
    }
  }

  void deleteAllKeys() {
    _storage.deleteAllData();
  }

  void cleanStateCurrentUser() {
    state = state.copyWith(
      username: null,
      password: null,
      isLoggedIn: false,
      user: null,
      id: null,
    );
  }

  void setId(Id id) {
    state = state.copyWith(id: id);
  }

  void setUsername(String? username) {
    if (state.username == username) return;
    state = state.copyWith(username: username);
  }

  void setPassword(String? password) {
    if (state.password == password) return;
    state = state.copyWith(password: password);
  }

  void setIsLoading(bool isLoading) {
    if (state.isLoading == isLoading) return;
    state = state.copyWith(isLoading: isLoading);
  }

  void setIsLoggedIn(bool isLoggedIn) {
    state = state.copyWith(isLoggedIn: isLoggedIn);
  }

  void setDoubleFactor(bool doubleFactor) {
    state = state.copyWith(doubleFactor: doubleFactor);
  }

  void setShowAlertStatusSesion(bool showAlertStatusSesion) {
    state = state.copyWith(showAlertStatusSesion: showAlertStatusSesion);
  }
}

class CheckerNotifier extends StateNotifier<SettingsCheckerState> {
  CheckerNotifier() : super(SettingsCheckerState());

  final shorebirdCodePush = ShorebirdCodePush();

  Future<void> init() async {
    if (state.isChecking) return;

    state = state.copyWith(isChecking: true);

    await checkUpdatesNotes();
    await getCurrentVersion();
    await checkPatchUpdates();
  }

  Future<void> getCurrentVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();

    state = state.copyWith(currentVersion: packageInfo.version);
  }

  Future<void> checkUpdatesNotes() async {
    setIsLoading(true);

    final updates = await getNotesPatch();

    state = state.copyWith(
      updates: updates,
    );

    setIsLoading(false);
  }

  Future<void> checkPatchUpdates() async {
    setIsLoading(true);

    final isUpdateAvailable =
        await shorebirdCodePush.isNewPatchAvailableForDownload();

    if (isUpdateAvailable) {
      final updateIsImportant =
          state.updates.where((element) => element.isImportant).first;
      if (updateIsImportant.isImportant) {
        await downloadUpdate();
        Restart.restartApp();
      }
    }

    state = state.copyWith(
      isUpdateAvailable: isUpdateAvailable,
      isLoading: false,
    );
  }

  Future<void> downloadUpdate() async {
    setIsLoading(true);

    await shorebirdCodePush.downloadUpdateIfAvailable();

    try {
      final canInstallUpdate =
          await shorebirdCodePush.isNewPatchReadyToInstall();

      if (!canInstallUpdate) throw Exception('Update not ready to install');

      state = state.copyWith(isUpdateDownloaded: true);
    } catch (e) {
      log('downloadUpdate error: $e', name: 'downloadUpdate error provider');
    } finally {
      setIsLoading(false);
    }
  }

  void setIsLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }
}

class SettingsAccountState {
  String? username;
  String? password;
  ValorantUser? user;
  bool doubleFactor;
  bool showAlertStatusSesion;
  bool isLoggedIn;
  bool isLoading;
  List<Account>? accounts;
  Id? id;
  SettingsAccountState({
    this.username,
    this.password,
    this.isLoggedIn = false,
    this.isLoading = false,
    this.doubleFactor = false,
    this.showAlertStatusSesion = false,
    this.id,
    this.accounts,
    this.user,
  });

  SettingsAccountState copyWith({
    String? username,
    String? password,
    bool? isLoggedIn,
    bool? isLoading,
    bool? doubleFactor,
    bool? showAlertStatusSesion,
    Id? id,
    List<Account>? accounts,
    ValorantUser? user,
  }) {
    return SettingsAccountState(
      username: username ?? this.username,
      password: password ?? this.password,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
      doubleFactor: doubleFactor ?? this.doubleFactor,
      showAlertStatusSesion:
          showAlertStatusSesion ?? this.showAlertStatusSesion,
      id: id ?? this.id,
      accounts: accounts ?? this.accounts,
      user: user ?? this.user,
    );
  }
}

class SettingsCheckerState {
  final String currentVersionPatch;
  final String? currentVersion;
  final bool isChecking;
  final bool isLoading;
  final bool isUpdateAvailable;
  final bool isUpdateDownloaded;
  final List<ResumePatch> updates;

  SettingsCheckerState({
    this.currentVersionPatch = '0',
    this.currentVersion,
    this.isLoading = true,
    this.isUpdateAvailable = false,
    this.isUpdateDownloaded = false,
    this.isChecking = false,
    this.updates = const [],
  });

  SettingsCheckerState copyWith({
    String? currentVersionPatch,
    String? currentVersion,
    bool? isLoading,
    bool? isUpdateAvailable,
    bool? isUpdateDownloaded,
    bool? isChecking,
    List<ResumePatch>? updates,
  }) {
    return SettingsCheckerState(
      currentVersionPatch: currentVersionPatch ?? this.currentVersionPatch,
      currentVersion: currentVersion ?? this.currentVersion,
      isLoading: isLoading ?? this.isLoading,
      isUpdateAvailable: isUpdateAvailable ?? this.isUpdateAvailable,
      isUpdateDownloaded: isUpdateDownloaded ?? this.isUpdateDownloaded,
      isChecking: isChecking ?? this.isChecking,
      updates: updates ?? this.updates,
    );
  }
}
