class Wallet {
  final int? valorantPoints;
  final int? radianitePoints;
  final int? money;

  Wallet({
    this.valorantPoints,
    this.radianitePoints,
    this.money,
  });

  Wallet copyWith({
    int? valorantPoints,
    int? radianitePoints,
    int? money,
  }) =>
      Wallet(
        valorantPoints: valorantPoints ?? this.valorantPoints,
        radianitePoints: radianitePoints ?? this.radianitePoints,
        money: money ?? this.money,
      );

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
        valorantPoints: json['ValorantPoints'],
        radianitePoints: json['RadianitePoints'],
        money: json['Money'],
      );

  Map<String, dynamic> toJson() => {
        'ValorantPoints': valorantPoints,
        'RadianitePoints': radianitePoints,
        'Money': money,
      };
}
