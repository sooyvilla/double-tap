class WalletResponse {
  final Map<String, int>? balances;

  WalletResponse({
    this.balances,
  });

  WalletResponse copyWith({
    Map<String, int>? balances,
  }) =>
      WalletResponse(
        balances: balances ?? this.balances,
      );

  factory WalletResponse.fromJson(Map<String, dynamic> json) => WalletResponse(
        balances: Map.from(json['Balances']!)
            .map((k, v) => MapEntry<String, int>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        'Balances':
            Map.from(balances!).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };

  Map<String, int> toMap() {
    return Map.from(balances!).map((k, v) => MapEntry<String, int>(k, v));
  }
}
