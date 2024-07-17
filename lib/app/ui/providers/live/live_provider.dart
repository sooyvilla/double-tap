// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:double_tap/app/data/models/store_user.dart';
import 'package:double_tap/app/data/repositories/valorant_api_live_repository.dart';
import 'package:double_tap/app/domain/entities/party_user.dart';
import 'package:double_tap/app/domain/entities/wallet.dart';
import 'package:double_tap/app/ui/providers/live/live_provider_imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../config/config.dart';
import '../../../domain/mappers/vallet_mapper.dart';

final liveProvider = StateNotifierProvider<LiveProvider, LiveState>((ref) {
  final datasource = ref.watch(liveProviderImp);
  return LiveProvider(datasource);
});

class LiveProvider extends StateNotifier<LiveState> {
  LiveProvider(this.datasource) : super(LiveState());

  final _prefs = SharedPreferencesConfig.prefs;
  final ValorantApiLiveRepository datasource;

  Future<void> init() async {
    setIsLoading(true);
    await Future.wait([
      getStore(),
      getWallet(),
    ]);
    setIsLoading(false);
  }

  Future<void> getStore() async {
    if (state.storeUser != null) return;
    try {
      final response = await datasource.getStore();
      state = state.copyWith(storeUser: response);
    } catch (e) {
      log('getStore error: $e', name: 'getStore error');
    }
  }

  Future<void> getWallet() async {
    try {
      final response = await datasource.wallet();
      final wallet = mapVallet(response);
      state = state.copyWith(wallet: wallet);
    } catch (e) {
      log('wallet error: $e', name: 'wallet error');
    }
  }

  void cleanAll() {
    state = state.copyWith(
      storeUser: null,
      wallet: null,
      partyUser: null,
    );
  }

  void setIsLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }
}

class LiveState {
  final PartyUser? partyUser;
  final bool isLoading;
  final int? coldDown;
  final StoreUser? storeUser;
  final Wallet? wallet;

  LiveState({
    this.partyUser,
    this.isLoading = false,
    this.coldDown,
    this.storeUser,
    this.wallet,
  });

  LiveState copyWith({
    PartyUser? partyUser,
    bool? isLoading,
    int? coldDown,
    StoreUser? storeUser,
    Wallet? wallet,
  }) {
    return LiveState(
      partyUser: partyUser,
      isLoading: isLoading ?? this.isLoading,
      coldDown: coldDown ?? this.coldDown,
      storeUser: storeUser ?? this.storeUser,
      wallet: wallet ?? this.wallet,
    );
  }

  @override
  String toString() {
    return 'LiveState(partyUser: $partyUser, isLoading: $isLoading, coldDown: $coldDown, storeUser: $storeUser, wallet: $wallet)';
  }
}
