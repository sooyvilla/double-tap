import 'dart:developer';

class UserV1 {
  final String? country;
  final String? sub;
  final bool? emailVerified;
  final dynamic playerPlocale;
  final int? countryAt;
  final Pw? pw;
  final bool? phoneNumberVerified;
  final bool? accountVerified;
  final dynamic ppid;
  final List<dynamic>? federatedIdentityDetails;
  final String? playerLocale;
  final Acct? acct;
  final int? age;
  final String? jti;
  final Affinity? affinity;
  final Identity? identity;

  UserV1({
    this.country,
    this.identity,
    this.sub,
    this.emailVerified,
    this.playerPlocale,
    this.countryAt,
    this.pw,
    this.phoneNumberVerified,
    this.accountVerified,
    this.ppid,
    this.federatedIdentityDetails,
    this.playerLocale,
    this.acct,
    this.age,
    this.jti,
    this.affinity,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'country': country,
      'sub': sub,
      'emailVerified': emailVerified,
      'playerPlocale': playerPlocale,
      'countryAt': countryAt,
      'pw': pw?.toMap(),
      'phoneNumberVerified': phoneNumberVerified,
      'accountVerified': accountVerified,
      'ppid': ppid,
      'federatedIdentityDetails': federatedIdentityDetails,
      'playerLocale': playerLocale,
      'acct': acct?.toMap(),
      'age': age,
      'jti': jti,
      'affinity': affinity?.toMap(),
    };
  }

  factory UserV1.fromMap(Map<String, dynamic> map) {
    return UserV1(
      country: map['country'] != null ? map['country'] as String : null,
      sub: map['sub'] != null ? map['sub'] as String : null,
      emailVerified:
          map['emailVerified'] != null ? map['emailVerified'] as bool : null,
      playerPlocale: map['playerPlocale'] as dynamic,
      countryAt: map['countryAt'] != null ? map['countryAt'] as int : null,
      pw: map['pw'] != null
          ? Pw.fromMap(map['pw'] as Map<String, dynamic>)
          : null,
      phoneNumberVerified: map['phoneNumberVerified'] != null
          ? map['phoneNumberVerified'] as bool
          : null,
      accountVerified: map['accountVerified'] != null
          ? map['accountVerified'] as bool
          : null,
      ppid: map['ppid'] as dynamic,
      federatedIdentityDetails: map['federatedIdentityDetails'] != null
          ? List<dynamic>.from(
              (map['federatedIdentityDetails'] as List<dynamic>))
          : null,
      playerLocale:
          map['playerLocale'] != null ? map['playerLocale'] as String : null,
      acct: map['acct'] != null
          ? Acct.fromMap(map['acct'] as Map<String, dynamic>)
          : null,
      age: map['age'] != null ? map['age'] as int : null,
      jti: map['jti'] != null ? map['jti'] as String : null,
      affinity: map['affinity'] != null
          ? Affinity.fromMap(map['affinity'] as Map<String, dynamic>)
          : null,
      identity: map['identity'] != null
          ? Identity.fromMap(map['identity'] as Map<String, dynamic>)
          : null,
    );
  }
}

class Identity {
  final String? playerCardID;
  final String? playerTitleID;
  final int? accountLevel;
  final String? preferredLevelBorderID;
  final bool? hideAccountLevel;

  Identity({
    this.playerCardID,
    this.playerTitleID,
    this.accountLevel,
    this.preferredLevelBorderID,
    this.hideAccountLevel,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'playerCardID': playerCardID,
      'playerTitleID': playerTitleID,
      'accountLevel': accountLevel,
      'preferredLevelBorderID': preferredLevelBorderID,
      'hideAccountLevel': hideAccountLevel,
    };
  }

  factory Identity.fromMap(Map<String, dynamic> map) {
    return Identity(
      playerCardID:
          map['PlayerCardID'] != null ? map['PlayerCardID'] as String : null,
      playerTitleID:
          map['PlayerTitleID'] != null ? map['PlayerTitleID'] as String : null,
      accountLevel:
          map['AccountLevel'] != null ? map['AccountLevel'] as int : null,
      preferredLevelBorderID: map['PreferredLevelBorderID'] != null
          ? map['PreferredLevelBorderID'] as String
          : null,
      hideAccountLevel: map['HideAccountLevel'] != null
          ? map['HideAccountLevel'] as bool
          : null,
    );
  }
}

class Acct {
  final int? type;
  final String? state;
  final bool? adm;
  final String? gameName;
  final String? tagLine;
  final int? createdAt;

  Acct({
    this.type,
    this.state,
    this.adm,
    this.gameName,
    this.tagLine,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type,
      'state': state,
      'adm': adm,
      'gameName': gameName,
      'tagLine': tagLine,
      'createdAt': createdAt,
    };
  }

  factory Acct.fromMap(Map<String, dynamic> map) {
    return Acct(
      type: map['type'] != null ? map['type'] as int : null,
      state: map['state'] != null ? map['state'] as String : null,
      adm: map['adm'] != null ? map['adm'] as bool : null,
      gameName: map['game_name'] != null ? map['game_name'] as String : null,
      tagLine: map['tag_line'] != null ? map['tag_line'] as String : null,
      createdAt: map['createdAt'] != null ? map['createdAt'] as int : null,
    );
  }
}

class Affinity {
  final String? pp;

  Affinity({
    this.pp,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'pp': pp,
    };
  }

  factory Affinity.fromMap(Map<String, dynamic> map) {
    return Affinity(
      pp: map['pp'] != null ? map['pp'] as String : null,
    );
  }
}

class Pw {
  final int? cngAt;
  final bool? reset;
  final bool? mustReset;

  Pw({
    this.cngAt,
    this.reset,
    this.mustReset,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cngAt': cngAt,
      'reset': reset,
      'mustReset': mustReset,
    };
  }

  factory Pw.fromMap(Map<String, dynamic> map) {
    return Pw(
      cngAt: map['cngAt'] != null ? map['cngAt'] as int : null,
      reset: map['reset'] != null ? map['reset'] as bool : null,
      mustReset: map['mustReset'] != null ? map['mustReset'] as bool : null,
    );
  }
}
