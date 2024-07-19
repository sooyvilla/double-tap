import 'dart:developer';

import 'package:double_tap/app/config/config.dart';
import 'package:double_tap/app/domain/entities/valorant_user.dart';
import 'package:double_tap/app/ui/providers/providers.dart';
import 'package:double_tap/app/ui/providers/settings/settings_provider_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';

import '../../../config/isar/isar_instance.dart';
import '../../../data/repositories/valorant_api_auth_repository.dart';
import '../../../domain/entities/account.dart';
import '../../../domain/mappers/players_mapper.dart';

final settingsProvider =
    StateNotifierProvider<AccountNotifier, SettingsState>((ref) {
  final datasource = ref.watch(settingsProviderImp);
  return AccountNotifier(
    datasource: datasource,
    ref: ref,
  );
});

class AccountNotifier extends StateNotifier<SettingsState> {
  AccountNotifier({
    required this.datasource,
    required this.ref,
  }) : super(SettingsState());

  final ValorantApiAuthRepository datasource;
  final StateNotifierProviderRef<AccountNotifier, SettingsState> ref;

  final prefs = SharedPreferencesConfig.prefs;

  Future<void> login() async {
    setIsLoading(true);
    setEnableAddMultiCounts(true);

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
      await logout();
    } finally {
      setIsLoading(false);
    }
  }

  Future<void> addAccount() async {
    setIsLoading(true);
    setEnableAddMultiCounts(true);
    final isar = IsarInstance();
    final oldId = state.id;
    try {
      // final response = await datasource.login(state.username!, state.password!);

      // if (!response) {
      //   setDoubleFactor(true);
      //   return;
      // }
      // await setUser();
      // await saveAccount();
      final oldAccount = await isar.getAccount(oldId!);
      oldAccount!.isLoggedIn = false;
      isar.updateAccount(oldAccount);
      await login();

      // await getAllAccounts();
      // ref.read(liveProvider.notifier).cleanAll();
      // await ref.read(liveProvider.notifier).init();
      setIsLoggedIn(true);
    } catch (e) {
      log('addAccount error: $e', name: 'addAccount error provider');
      await logout();
    } finally {
      setIsLoading(false);
    }
  }

  Future<void> validateSession() async {
    setIsLoading(true);
    final isar = IsarInstance();
    try {
      final accounts = await isar.getAllAccounts();
      if (accounts.isEmpty) {
        setIsLoading(false);
        setIsLoggedIn(false);
        return;
      }
      final accountLogged =
          accounts.where((element) => element.isLoggedIn).toList();
      if (accountLogged.isEmpty) {
        state = state.copyWith(accounts: accounts);
        return;
      }
      state = state.copyWith(
        username: accountLogged.first.username,
        password: accountLogged.first.password,
      );
      await login();
    } catch (e) {
      log('validateSession error: $e', name: 'validateSession error provider');
      logout();
    } finally {
      setIsLoading(false);
    }
  }

  Future<void> getAllAccounts() async {
    setIsLoading(true);
    final isar = IsarInstance();

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
      if (state.id != null) {
        final oldAccount = await isar.getAccount(state.id!);
        oldAccount!.isLoggedIn = false;
        isar.updateAccount(oldAccount);
      }
      final account = await isar.getAccount(id);
      state = state.copyWith(
        username: account!.username,
        password: account.password,
        isLoggedIn: false,
        id: null,
        user: null,
      );

      await login();
      final newAccount = await isar.getAccount(state.id!);
      newAccount!.isLoggedIn = true;
      isar.updateAccount(newAccount);
      await getAllAccounts();
    } catch (e) {
      log('switchAccount error: $e', name: 'switchAccount error provider');
    }
    setIsLoading(false);
  }

  Future<void> loginWebView(String token) async {
    setIsLoading(true);
    setEnableAddMultiCounts(false);
    //todo: delete all accounts
    try {
      await datasource.loginWebView(token);

      await setUser();
    } catch (e) {
      log('loginWebView error: $e', name: 'loginWebView error provider');
    }
    setIsLoading(false);
  }

  Future<void> setUser() async {
    try {
      final user = await datasource.getInfoPlayer();
      state = state.copyWith(user: mapPlayer(user));
      setIsLoggedIn(true);
    } catch (e) {
      logout();
    }
  }

  Future<void> saveAccount() async {
    final isar = IsarInstance();

    final newAccount = Account(
      username: state.username!,
      password: state.password!,
      showName: state.user!.username!,
      tagLine: state.user!.tagLine!,
      isLoggedIn: true,
    );
    final validateAccount = await isar.validateIfExists(newAccount);
    if (validateAccount != null) {
      setId(validateAccount.isarId!);
      return;
    }

    final account = await isar.saveAccount(newAccount);
    setId(account.isarId!);
  }

  Future<void> logout() async {
    final isar = IsarInstance();
    final tempId = state.id;

    try {
      isar.deleteAccount(tempId!);
      await updateAllAccounts(tempId);
      setIsLoggedIn(false);
    } catch (e) {
      log('logout error: $e', name: 'logout error provider');
    }
  }

  Future<void> logoutAll() async {
    final isar = IsarInstance();
    final accounts = state.accounts!;
    final List<Id> ids = [];
    for (var account in accounts) {
      ids.add(account.isarId!);
    }
    state = state.copyWith(
      username: null,
      password: null,
      isLoggedIn: false,
      user: null,
      id: null,
    );
    try {
      for (var element in KeysAuth.allKeys) {
        prefs?.remove(element);
      }
      await isar.deleteAllAccounts(ids);
      await getAllAccounts();
      ref.read(liveProvider.notifier).cleanAll();
      setIsLoggedIn(false);
    } catch (e) {
      log('logoutAll error: $e', name: 'logoutAll error provider');
    }
  }

  void setId(Id id) {
    state = state.copyWith(id: id);
  }

  void setUsername(String username) {
    if (state.username == username) return;
    state = state.copyWith(username: username);
  }

  void setPassword(String password) {
    if (state.password == password) return;
    state = state.copyWith(password: password);
  }

  void setIsLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void setIsLoggedIn(bool isLoggedIn) {
    state = state.copyWith(isLoggedIn: isLoggedIn);
  }

  void setDoubleFactor(bool doubleFactor) {
    state = state.copyWith(doubleFactor: doubleFactor);
  }

  void setEnableAddMultiCounts(bool enableAddMultiCounts) {
    state = state.copyWith(enableAddMultiCounts: enableAddMultiCounts);
  }
}

class SettingsState {
  String? username;
  String? password;
  ValorantUser? user;
  bool doubleFactor;
  bool enableAddMultiCounts;
  bool isLoggedIn;
  bool isLoading;
  List<Account>? accounts;
  Id? id;
  SettingsState({
    this.username,
    this.password,
    this.isLoggedIn = false,
    this.isLoading = false,
    this.doubleFactor = false,
    this.enableAddMultiCounts = true,
    this.id,
    this.accounts,
    this.user,
  });

  SettingsState copyWith({
    String? username,
    String? password,
    bool? isLoggedIn,
    bool? isLoading,
    bool? doubleFactor,
    bool? enableAddMultiCounts,
    Id? id,
    List<Account>? accounts,
    ValorantUser? user,
  }) {
    return SettingsState(
      username: username ?? this.username,
      password: password ?? this.password,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
      doubleFactor: doubleFactor ?? this.doubleFactor,
      enableAddMultiCounts: enableAddMultiCounts ?? this.enableAddMultiCounts,
      id: id ?? this.id,
      accounts: accounts ?? this.accounts,
      user: user ?? this.user,
    );
  }
}
