class PlayerLoadoutResponse {
  String subject;
  int version;
  List<Gun> guns;
  List<Spray> sprays;
  Identity identity;
  bool incognito;

  PlayerLoadoutResponse({
    required this.subject,
    required this.version,
    required this.guns,
    required this.sprays,
    required this.identity,
    required this.incognito,
  });

  factory PlayerLoadoutResponse.fromJson(Map<String, dynamic> json) {
    return PlayerLoadoutResponse(
      subject: json['Subject'],
      version: json['Version'],
      guns: List<Gun>.from(json['Guns'].map((x) => Gun.fromJson(x))),
      sprays: List<Spray>.from(json['Sprays'].map((x) => Spray.fromJson(x))),
      identity: Identity.fromJson(json['Identity']),
      incognito: json['Incognito'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Subject': subject,
      'Version': version,
      'Guns': List<dynamic>.from(guns.map((x) => x.toJson())),
      'Sprays': List<dynamic>.from(sprays.map((x) => x.toJson())),
      'Identity': identity.toJson(),
      'Incognito': incognito,
    };
  }
}

class Gun {
  String id;
  String? charmInstanceID;
  String? charmID;
  String? charmLevelID;
  String skinID;
  String skinLevelID;
  String chromaID;
  List<dynamic> attachments;

  Gun({
    required this.id,
    this.charmInstanceID,
    this.charmID,
    this.charmLevelID,
    required this.skinID,
    required this.skinLevelID,
    required this.chromaID,
    required this.attachments,
  });

  factory Gun.fromJson(Map<String, dynamic> json) {
    return Gun(
      id: json['ID'],
      charmInstanceID: json['CharmInstanceID'],
      charmID: json['CharmID'],
      charmLevelID: json['CharmLevelID'],
      skinID: json['SkinID'],
      skinLevelID: json['SkinLevelID'],
      chromaID: json['ChromaID'],
      attachments: List<dynamic>.from(json['Attachments']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'CharmInstanceID': charmInstanceID,
      'CharmID': charmID,
      'CharmLevelID': charmLevelID,
      'SkinID': skinID,
      'SkinLevelID': skinLevelID,
      'ChromaID': chromaID,
      'Attachments': List<dynamic>.from(attachments.map((x) => x)),
    };
  }
}

class Spray {
  String equipSlotID;
  String sprayID;
  dynamic sprayLevelID;

  Spray({
    required this.equipSlotID,
    required this.sprayID,
    this.sprayLevelID,
  });

  factory Spray.fromJson(Map<String, dynamic> json) {
    return Spray(
      equipSlotID: json['EquipSlotID'],
      sprayID: json['SprayID'],
      sprayLevelID: json['SprayLevelID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'EquipSlotID': equipSlotID,
      'SprayID': sprayID,
      'SprayLevelID': sprayLevelID,
    };
  }
}

class Identity {
  String playerCardID;
  String playerTitleID;
  int accountLevel;
  String preferredLevelBorderID;
  bool hideAccountLevel;

  Identity({
    required this.playerCardID,
    required this.playerTitleID,
    required this.accountLevel,
    required this.preferredLevelBorderID,
    required this.hideAccountLevel,
  });

  factory Identity.fromJson(Map<String, dynamic> json) {
    return Identity(
      playerCardID: json['PlayerCardID'],
      playerTitleID: json['PlayerTitleID'],
      accountLevel: json['AccountLevel'],
      preferredLevelBorderID: json['PreferredLevelBorderID'],
      hideAccountLevel: json['HideAccountLevel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'PlayerCardID': playerCardID,
      'PlayerTitleID': playerTitleID,
      'AccountLevel': accountLevel,
      'PreferredLevelBorderID': preferredLevelBorderID,
      'HideAccountLevel': hideAccountLevel,
    };
  }
}
