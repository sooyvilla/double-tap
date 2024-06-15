class ValorantUser {
  final String? country;
  final String? region;
  final String? username;
  final String? tagLine;
  final Card? card;
  ValorantUser({
    this.country,
    this.region,
    this.username,
    this.tagLine,
    this.card,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'country': country,
      'region': region,
      'username': username,
      'tagLine': tagLine,
      'card': card?.toJson(),
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
