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

  Future<void> validateSession() async {
    setIsLoading(true);
    final accessToken = prefs?.getString(KeysAuth.accessToken);
    if (accessToken != null) {
      try {
        await datasource.reauthentication();
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

  void setIsLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void setIsLoggedIn(bool isLoggedIn) {
    state = state.copyWith(isLoggedIn: isLoggedIn);
  }
}

class SettingsState {
  ValorantUser? user;
  bool isLoggedIn;
  bool isLoading;
  SettingsState({
    this.isLoggedIn = false,
    this.isLoading = false,
    this.user,
  });

  SettingsState copyWith({
    bool? isLoggedIn,
    bool? isLoading,
    ValorantUser? user,
  }) {
    return SettingsState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
    );
  }
}
