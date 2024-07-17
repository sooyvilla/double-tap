// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:double_tap/app/config/config.dart';
import 'package:double_tap/app/domain/entities/valorant_user.dart';
import 'package:double_tap/app/ui/providers/settings/settings_provider_imp.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/repositories/valorant_api_auth_repository.dart';
import '../../../domain/mappers/players_mapper.dart';

final settingsProvider =
    StateNotifierProvider<AccountNotifier, SettingsState>((ref) {
  final datasource = ref.watch(settingsProviderImp);
  return AccountNotifier(
    datasource: datasource,
  );
});

class AccountNotifier extends StateNotifier<SettingsState> {
  AccountNotifier({
    required this.datasource,
  }) : super(SettingsState());

  final ValorantApiAuthRepository datasource;

  final prefs = SharedPreferencesConfig.prefs;

  Future<void> login() async {
    setIsLoading(true);
    try {
      final response = await datasource.login(state.username!, state.password!);

      if (!response) {
        return;
      }
      await setUser();
    } catch (e) {
      log('login error: $e', name: 'login error provider');
    } finally {
      setIsLoading(false);
    }
  }

  Future<void> validateSession() async {
    setIsLoading(true);
    final accessToken = prefs?.getString(KeysAuth.accessToken);
    if (accessToken != null) {
      try {
        // await datasource.reauthentication();
        await setUser();
        setIsLoggedIn(true);
      } catch (e) {
        logout();
      }
    }
    setIsLoading(false);
  }

  Future<void> loginWebView(String token) async {
    setIsLoading(true);
    try {
      await datasource.loginWebView(token);

      await setUser();
    } catch (e) {
      log('loginWebView error: $e', name: 'loginWebView error provider');
    }
    setIsLoading(false);
  }

  void logout() {
    for (var element in KeysAuth.allKeys) {
      prefs?.remove(element);
    }
    state = state.copyWith(
      username: null,
      password: null,
      isLoggedIn: false,
      user: null,
    );
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
}

class SettingsState {
  String? username;
  String? password;
  ValorantUser? user;
  bool isLoggedIn;
  bool isLoading;
  SettingsState({
    this.username,
    this.password,
    this.isLoggedIn = false,
    this.isLoading = false,
    this.user,
  });

  SettingsState copyWith({
    String? username,
    String? password,
    bool? isLoggedIn,
    bool? isLoading,
    ValorantUser? user,
  }) {
    return SettingsState(
      username: username ?? this.username,
      password: password ?? this.password,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
    );
  }
}
