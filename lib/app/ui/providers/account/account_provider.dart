// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:insane_bolt/app/config/config.dart';
import 'package:insane_bolt/app/config/constants/keys.dart';
import 'package:insane_bolt/app/ui/providers/account/account_provider_imp.dart';

import '../../../data/repositories/valorant_api_auth_repository.dart';

final accountProvider =
    StateNotifierProvider<AccountNotifier, AccountState>((ref) {
  final datasource = ref.watch(accountProviderImp);
  return AccountNotifier(datasource);
});

class AccountNotifier extends StateNotifier<AccountState> {
  AccountNotifier(this.datasource) : super(AccountState());

  final ValorantApiAuthRepositoryImp datasource;

  final prefs = SharedPreferencesConfig.prefs;

  Future<void> login() async {
    setIsLoading(true);
    try {
      final response = await datasource.login(state.username!, state.password!);

      if (!response) {
        return;
      }
      await setPlayer();
    } catch (e) {
      log('login error: $e', name: 'login error provider');
    } finally {
      setIsLoading(false);
    }
  }

  Future<void> validateSession() async {
    setIsLoading(true);
    if (prefs?.getString(KeysAuth.accessToken) != null) {
      await datasource.reauthentication();
      await setPlayer();
      setIsLoggedIn(true);
    }
    setIsLoading(false);
  }

  Future<void> loginWebView(String token) async {
    setIsLoading(true);
    try {
      await datasource.loginWebView(token);

      await setPlayer();
    } catch (e) {
      log('loginWebView error: $e', name: 'loginWebView error provider');
    } finally {
      setIsLoading(false);
    }
  }

  void logout() {
    for (var element in KeysAuth.allKeys) {
      prefs?.remove(element);
    }

    state = state.copyWith(
      username: null,
      password: null,
      isLoggedIn: false,
    );
  }

  Future<void> setPlayer() async {
    final user = await datasource.getInfoPlayer();
    setUser(user.acct!.gameName!);
    setTagLine(user.acct!.tagLine!);
    setIsLoggedIn(true);
  }

  void setUser(String username) {
    if (state.username == username) return;
    state = state.copyWith(username: username);
  }

  void setTagLine(String tagLine) {
    state = state.copyWith(tagLine: tagLine);
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
}

class AccountState {
  String? username;
  String? tagLine;
  String? password;
  bool isLoggedIn;
  bool isLoading;
  AccountState({
    this.username,
    this.password,
    this.isLoggedIn = false,
    this.isLoading = false,
    this.tagLine,
  });

  AccountState copyWith({
    String? username,
    String? password,
    bool? isLoggedIn,
    bool? isLoading,
    String? tagLine,
  }) {
    return AccountState(
      username: username ?? this.username,
      password: password ?? this.password,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
      tagLine: tagLine ?? this.tagLine,
    );
  }
}
