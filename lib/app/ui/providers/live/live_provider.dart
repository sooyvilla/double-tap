import 'dart:developer';

import 'package:double_tap/app/data/models/store_user.dart';
import 'package:double_tap/app/data/repositories/valorant_api_live_repository.dart';
import 'package:double_tap/app/domain/entities/wallet.dart';
import 'package:double_tap/app/ui/providers/live/live_provider_imp.dart';
import 'package:double_tap/app/ui/providers/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/mappers/vallet_mapper.dart';

final liveProvider = StateNotifierProvider<LiveProvider, LiveState>((ref) {
  final datasource = ref.watch(liveProviderImp);
  return LiveProvider(datasource, ref);
});

class LiveProvider extends StateNotifier<LiveState> {
  LiveProvider(this.datasource, this.ref) : super(LiveState());

  final ValorantApiLiveRepository datasource;
  final Ref ref;

  Future<void> init() async {
    setIsLoading(true);
    await Future.wait([
      getStore(),
      getWallet(),
    ]);
    setIsLoading(false);
  }

  Future<void> getStore() async {
    try {
      final response = await datasource.getStore();
      state = state.copyWith(storeUser: response);
    } catch (e) {
      ref.read(settingsAccountProvider.notifier).validateSession();
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
    );
  }

  void setIsLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }
}

class LiveState {
  final bool isLoading;
  final StoreUser? storeUser;
  final Wallet? wallet;

  LiveState({
    this.isLoading = false,
    this.storeUser,
    this.wallet,
  });

  LiveState copyWith({
    bool? isLoading,
    int? coldDown,
    StoreUser? storeUser,
    Wallet? wallet,
  }) {
    return LiveState(
      isLoading: isLoading ?? this.isLoading,
      storeUser: storeUser ?? this.storeUser,
      wallet: wallet ?? this.wallet,
    );
  }

  @override
  String toString() {
    return 'LiveState(partyUser: isLoading: $isLoading, storeUser: $storeUser, wallet: $wallet)';
  }
}
