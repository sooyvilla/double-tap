class ValorantUser {
  final String? country;
  final String? region;
  final String? username;
  final String? tagLine;
  final Card? card;
  final String? puuid;
  final String? levelAccount;
  final String? playerTitle;
  ValorantUser({
    this.country,
    this.region,
    this.username,
    this.tagLine,
    this.card,
    this.puuid,
    this.levelAccount,
    this.playerTitle,
  });

  ValorantUser copyWith({
    String? country,
    String? region,
    String? username,
    String? tagLine,
    Card? card,
    String? puuid,
    String? levelAccount,
    String? apodo,
  }) {
    return ValorantUser(
      country: country ?? this.country,
      region: region ?? this.region,
      username: username ?? this.username,
      tagLine: tagLine ?? this.tagLine,
      card: card ?? this.card,
      puuid: puuid ?? this.puuid,
      levelAccount: levelAccount ?? this.levelAccount,
      playerTitle: apodo ?? playerTitle,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'country': country,
      'region': region,
      'username': username,
      'tagLine': tagLine,
      'puuid': puuid,
      'levelAccount': levelAccount,
      'apodo': playerTitle,
    };
  }

  factory ValorantUser.fromMap(Map<String, dynamic> map) {
    return ValorantUser(
      country: map['country'] != null ? map['country'] as String : null,
      region: map['region'] != null ? map['region'] as String : null,
      username: map['username'] != null ? map['username'] as String : null,
      tagLine: map['tagLine'] != null ? map['tagLine'] as String : null,
      card: map['card'] != null
          ? Card.fromJson(map['card'] as Map<String, dynamic>)
          : null,
      puuid: map['puuid'] as String,
      levelAccount:
          map['levelAccount'] != null ? map['levelAccount'] as String : null,
      playerTitle: map['apodo'] != null ? map['apodo'] as String : null,
    );
  }
}

class Card {
  String? small;
  String? large;
  String? wide;
  String? id;

  Card({this.small, this.large, this.wide, this.id});

  Card.fromJson(Map<String, dynamic> json) {
    small = json['small'];
    large = json['large'];
    wide = json['wide'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['small'] = small;
    data['large'] = large;
    data['wide'] = wide;
    data['id'] = id;
    return data;
  }
}
