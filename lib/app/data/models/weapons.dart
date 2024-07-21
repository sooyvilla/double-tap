import 'dart:convert';

class WeaponsSkins {
  final int? status;
  final List<Weapon>? data;

  WeaponsSkins({
    this.status,
    this.data,
  });

  factory WeaponsSkins.fromRawJson(String str) =>
      WeaponsSkins.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WeaponsSkins.fromJson(Map<String, dynamic> json) => WeaponsSkins(
        status: json['status'],
        data: json['data'] == null
            ? []
            : List<Weapon>.from(json['data']!.map((x) => Weapon.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'data': data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Weapon {
  final String? uuid;
  final String? displayName;
  final String? themeUuid;
  final String? contentTierUuid;
  final String? displayIcon;
  final String? wallpaper;
  final String? assetPath;
  final List<Chroma>? chromas;
  final List<Level>? levels;

  Weapon({
    this.uuid,
    this.displayName,
    this.themeUuid,
    this.contentTierUuid,
    this.displayIcon,
    this.wallpaper,
    this.assetPath,
    this.chromas,
    this.levels,
  });

  factory Weapon.fromRawJson(String str) => Weapon.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Weapon.fromJson(Map<String, dynamic> json) => Weapon(
        uuid: json['uuid'],
        displayName: json['displayName'],
        themeUuid: json['themeUuid'],
        contentTierUuid: json['contentTierUuid'],
        displayIcon: json['displayIcon'],
        wallpaper: json['wallpaper'],
        assetPath: json['assetPath'],
        chromas: json['chromas'] == null
            ? []
            : List<Chroma>.from(
                json['chromas']!.map((x) => Chroma.fromJson(x))),
        levels: json['levels'] == null
            ? []
            : List<Level>.from(json['levels']!.map((x) => Level.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'displayName': displayName,
        'themeUuid': themeUuid,
        'contentTierUuid': contentTierUuid,
        'displayIcon': displayIcon,
        'wallpaper': wallpaper,
        'assetPath': assetPath,
        'chromas': chromas == null
            ? []
            : List<dynamic>.from(chromas!.map((x) => x.toJson())),
        'levels': levels == null
            ? []
            : List<dynamic>.from(levels!.map((x) => x.toJson())),
      };
}

class Chroma {
  final String? uuid;
  final String? displayName;
  final String? displayIcon;
  final String? fullRender;
  final String? swatch;
  final String? streamedVideo;
  final String? assetPath;

  Chroma({
    this.uuid,
    this.displayName,
    this.displayIcon,
    this.fullRender,
    this.swatch,
    this.streamedVideo,
    this.assetPath,
  });

  factory Chroma.fromRawJson(String str) => Chroma.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Chroma.fromJson(Map<String, dynamic> json) => Chroma(
        uuid: json['uuid'],
        displayName: json['displayName'],
        displayIcon: json['displayIcon'],
        fullRender: json['fullRender'],
        swatch: json['swatch'],
        streamedVideo: json['streamedVideo'],
        assetPath: json['assetPath'],
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'displayName': displayName,
        'displayIcon': displayIcon,
        'fullRender': fullRender,
        'swatch': swatch,
        'streamedVideo': streamedVideo,
        'assetPath': assetPath,
      };
}

class Level {
  final String? uuid;
  final String? displayName;
  final String? levelItem;
  final String? displayIcon;
  final String? streamedVideo;
  final String? assetPath;

  Level({
    this.uuid,
    this.displayName,
    this.levelItem,
    this.displayIcon,
    this.streamedVideo,
    this.assetPath,
  });

  factory Level.fromRawJson(String str) => Level.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Level.fromJson(Map<String, dynamic> json) => Level(
        uuid: json['uuid'],
        displayName: json['displayName'],
        levelItem: json['levelItem'],
        displayIcon: json['displayIcon'],
        streamedVideo: json['streamedVideo'],
        assetPath: json['assetPath'],
      );

  Map<String, dynamic> toJson() => {
        'uuid': uuid,
        'displayName': displayName,
        'levelItem': levelItem,
        'displayIcon': displayIcon,
        'streamedVideo': streamedVideo,
        'assetPath': assetPath,
      };
}
