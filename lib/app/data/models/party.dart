class PartyResponsePriv {
  String id;
  String mucName;
  String voiceRoomID;
  int version;
  String clientVersion;
  List<Member> members;
  String state;
  String previousState;
  String stateTransitionReason;
  String accessibility;
  CustomGameData customGameData;
  MatchmakingData matchmakingData;
  dynamic invites;
  List<dynamic> requests;
  String queueEntryTime;
  ErrorNotification errorNotification;
  int restrictedSeconds;
  List<String> eligibleQueues;
  List<String> queueIneligibilities;
  CheatData cheatData;
  List<dynamic> xpBonuses;
  String inviteCode;

  PartyResponsePriv({
    required this.id,
    required this.mucName,
    required this.voiceRoomID,
    required this.version,
    required this.clientVersion,
    required this.members,
    required this.state,
    required this.previousState,
    required this.stateTransitionReason,
    required this.accessibility,
    required this.customGameData,
    required this.matchmakingData,
    required this.invites,
    required this.requests,
    required this.queueEntryTime,
    required this.errorNotification,
    required this.restrictedSeconds,
    required this.eligibleQueues,
    required this.queueIneligibilities,
    required this.cheatData,
    required this.xpBonuses,
    required this.inviteCode,
  });

  factory PartyResponsePriv.fromJson(Map<String, dynamic> json) {
    return PartyResponsePriv(
      id: json['ID'],
      mucName: json['MUCName'],
      voiceRoomID: json['VoiceRoomID'],
      version: json['Version'],
      clientVersion: json['ClientVersion'],
      members:
          List<Member>.from(json['Members'].map((x) => Member.fromJson(x))),
      state: json['State'],
      previousState: json['PreviousState'],
      stateTransitionReason: json['StateTransitionReason'],
      accessibility: json['Accessibility'],
      customGameData: CustomGameData.fromJson(json['CustomGameData']),
      matchmakingData: MatchmakingData.fromJson(json['MatchmakingData']),
      invites: json['Invites'],
      requests: List<dynamic>.from(json['Requests']),
      queueEntryTime: json['QueueEntryTime'],
      errorNotification: ErrorNotification.fromJson(json['ErrorNotification']),
      restrictedSeconds: json['RestrictedSeconds'],
      eligibleQueues: List<String>.from(json['EligibleQueues']),
      queueIneligibilities: List<String>.from(json['QueueIneligibilities']),
      cheatData: CheatData.fromJson(json['CheatData']),
      xpBonuses: List<dynamic>.from(json['XPBonuses']),
      inviteCode: json['InviteCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'MUCName': mucName,
      'VoiceRoomID': voiceRoomID,
      'Version': version,
      'ClientVersion': clientVersion,
      'Members': List<dynamic>.from(members.map((x) => x.toJson())),
      'State': state,
      'PreviousState': previousState,
      'StateTransitionReason': stateTransitionReason,
      'Accessibility': accessibility,
      'CustomGameData': customGameData.toJson(),
      'MatchmakingData': matchmakingData.toJson(),
      'Invites': invites,
      'Requests': List<dynamic>.from(requests),
      'QueueEntryTime': queueEntryTime,
      'ErrorNotification': errorNotification.toJson(),
      'RestrictedSeconds': restrictedSeconds,
      'EligibleQueues': List<dynamic>.from(eligibleQueues.map((x) => x)),
      'QueueIneligibilities':
          List<dynamic>.from(queueIneligibilities.map((x) => x)),
      'CheatData': cheatData.toJson(),
      'XPBonuses': List<dynamic>.from(xpBonuses.map((x) => x)),
      'InviteCode': inviteCode,
    };
  }
}

class Member {
  String subject;
  int competitiveTier;
  PlayerIdentity playerIdentity;
  dynamic seasonalBadgeInfo;
  bool? isOwner;
  int queueEligibleRemainingAccountLevels;
  List<Ping> pings;
  bool isReady;
  bool isModerator;
  bool useBroadcastHUD;
  String platformType;

  Member({
    required this.subject,
    required this.competitiveTier,
    required this.playerIdentity,
    this.seasonalBadgeInfo,
    this.isOwner,
    required this.queueEligibleRemainingAccountLevels,
    required this.pings,
    required this.isReady,
    required this.isModerator,
    required this.useBroadcastHUD,
    required this.platformType,
  });

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(
      subject: json['Subject'],
      competitiveTier: json['CompetitiveTier'],
      playerIdentity: PlayerIdentity.fromJson(json['PlayerIdentity']),
      seasonalBadgeInfo: json['SeasonalBadgeInfo'],
      isOwner: json['IsOwner'],
      queueEligibleRemainingAccountLevels:
          json['QueueEligibleRemainingAccountLevels'],
      pings: List<Ping>.from(json['Pings'].map((x) => Ping.fromJson(x))),
      isReady: json['IsReady'],
      isModerator: json['IsModerator'],
      useBroadcastHUD: json['UseBroadcastHUD'],
      platformType: json['PlatformType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Subject': subject,
      'CompetitiveTier': competitiveTier,
      'PlayerIdentity': playerIdentity.toJson(),
      'SeasonalBadgeInfo': seasonalBadgeInfo,
      'IsOwner': isOwner,
      'QueueEligibleRemainingAccountLevels':
          queueEligibleRemainingAccountLevels,
      'Pings': List<dynamic>.from(pings.map((x) => x.toJson())),
      'IsReady': isReady,
      'IsModerator': isModerator,
      'UseBroadcastHUD': useBroadcastHUD,
      'PlatformType': platformType,
    };
  }
}

class PlayerIdentity {
  String subject;
  String playerCardID;
  String playerTitleID;
  int accountLevel;
  String preferredLevelBorderID;
  bool incognito;
  bool hideAccountLevel;

  PlayerIdentity({
    required this.subject,
    required this.playerCardID,
    required this.playerTitleID,
    required this.accountLevel,
    required this.preferredLevelBorderID,
    required this.incognito,
    required this.hideAccountLevel,
  });

  factory PlayerIdentity.fromJson(Map<String, dynamic> json) {
    return PlayerIdentity(
      subject: json['Subject'],
      playerCardID: json['PlayerCardID'],
      playerTitleID: json['PlayerTitleID'],
      accountLevel: json['AccountLevel'],
      preferredLevelBorderID: json['PreferredLevelBorderID'] ?? '',
      incognito: json['Incognito'],
      hideAccountLevel: json['HideAccountLevel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Subject': subject,
      'PlayerCardID': playerCardID,
      'PlayerTitleID': playerTitleID,
      'AccountLevel': accountLevel,
      'PreferredLevelBorderID': preferredLevelBorderID,
      'Incognito': incognito,
      'HideAccountLevel': hideAccountLevel,
    };
  }
}

class Ping {
  int ping;
  String gamePodID;

  Ping({
    required this.ping,
    required this.gamePodID,
  });

  factory Ping.fromJson(Map<String, dynamic> json) {
    return Ping(
      ping: json['Ping'],
      gamePodID: json['GamePodID'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Ping': ping,
      'GamePodID': gamePodID,
    };
  }
}

class CustomGameData {
  Settings settings;
  Membership membership;
  int maxPartySize;
  bool autobalanceEnabled;
  int autobalanceMinPlayers;
  bool hasRecoveryData;

  CustomGameData({
    required this.settings,
    required this.membership,
    required this.maxPartySize,
    required this.autobalanceEnabled,
    required this.autobalanceMinPlayers,
    required this.hasRecoveryData,
  });

  factory CustomGameData.fromJson(Map<String, dynamic> json) {
    return CustomGameData(
      settings: Settings.fromJson(json['Settings']),
      membership: Membership.fromJson(json['Membership']),
      maxPartySize: json['MaxPartySize'],
      autobalanceEnabled: json['AutobalanceEnabled'],
      autobalanceMinPlayers: json['AutobalanceMinPlayers'],
      hasRecoveryData: json['HasRecoveryData'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Settings': settings.toJson(),
      'Membership': membership.toJson(),
      'MaxPartySize': maxPartySize,
      'AutobalanceEnabled': autobalanceEnabled,
      'AutobalanceMinPlayers': autobalanceMinPlayers,
      'HasRecoveryData': hasRecoveryData,
    };
  }
}

class Settings {
  String map;
  String mode;
  bool useBots;
  String gamePod;
  GameRules? gameRules;

  Settings({
    required this.map,
    required this.mode,
    required this.useBots,
    required this.gamePod,
    this.gameRules,
  });

  factory Settings.fromJson(Map<String, dynamic> json) {
    return Settings(
      map: json['Map'],
      mode: json['Mode'],
      useBots: json['UseBots'],
      gamePod: json['GamePod'],
      gameRules: json['GameRules'] != null
          ? GameRules.fromJson(json['GameRules'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Map': map,
      'Mode': mode,
      'UseBots': useBots,
      'GamePod': gamePod,
      'GameRules': gameRules?.toJson(),
    };
  }
}

class GameRules {
  String? allowGameModifiers;
  String? isOvertimeWinByTwo;
  String? playOutAllRounds;
  String? skipMatchHistory;
  String? tournamentMode;

  GameRules({
    this.allowGameModifiers,
    this.isOvertimeWinByTwo,
    this.playOutAllRounds,
    this.skipMatchHistory,
    this.tournamentMode,
  });

  factory GameRules.fromJson(Map<String, dynamic> json) {
    return GameRules(
      allowGameModifiers: json['AllowGameModifiers'],
      isOvertimeWinByTwo: json['IsOvertimeWinByTwo'],
      playOutAllRounds: json['PlayOutAllRounds'],
      skipMatchHistory: json['SkipMatchHistory'],
      tournamentMode: json['TournamentMode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'AllowGameModifiers': allowGameModifiers,
      'IsOvertimeWinByTwo': isOvertimeWinByTwo,
      'PlayOutAllRounds': playOutAllRounds,
      'SkipMatchHistory': skipMatchHistory,
      'TournamentMode': tournamentMode,
    };
  }
}

class Membership {
  List<Participant>? teamOne;
  List<Participant>? teamTwo;
  List<Participant>? teamSpectate;
  List<Participant>? teamOneCoaches;
  List<Participant>? teamTwoCoaches;

  Membership({
    this.teamOne,
    this.teamTwo,
    this.teamSpectate,
    this.teamOneCoaches,
    this.teamTwoCoaches,
  });

  factory Membership.fromJson(Map<String, dynamic> json) {
    return Membership(
      teamOne: json['teamOne'] != null
          ? List<Participant>.from(
              json['teamOne'].map((x) => Participant.fromJson(x)))
          : null,
      teamTwo: json['teamTwo'] != null
          ? List<Participant>.from(
              json['teamTwo'].map((x) => Participant.fromJson(x)))
          : null,
      teamSpectate: json['teamSpectate'] != null
          ? List<Participant>.from(
              json['teamSpectate'].map((x) => Participant.fromJson(x)))
          : null,
      teamOneCoaches: json['teamOneCoaches'] != null
          ? List<Participant>.from(
              json['teamOneCoaches'].map((x) => Participant.fromJson(x)))
          : null,
      teamTwoCoaches: json['teamTwoCoaches'] != null
          ? List<Participant>.from(
              json['teamTwoCoaches'].map((x) => Participant.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'teamOne': teamOne != null
          ? List<dynamic>.from(teamOne!.map((x) => x.toJson()))
          : null,
      'teamTwo': teamTwo != null
          ? List<dynamic>.from(teamTwo!.map((x) => x.toJson()))
          : null,
      'teamSpectate': teamSpectate != null
          ? List<dynamic>.from(teamSpectate!.map((x) => x.toJson()))
          : null,
      'teamOneCoaches': teamOneCoaches != null
          ? List<dynamic>.from(teamOneCoaches!.map((x) => x.toJson()))
          : null,
      'teamTwoCoaches': teamTwoCoaches != null
          ? List<dynamic>.from(teamTwoCoaches!.map((x) => x.toJson()))
          : null,
    };
  }
}

class Participant {
  String subject;

  Participant({
    required this.subject,
  });

  factory Participant.fromJson(Map<String, dynamic> json) {
    return Participant(
      subject: json['Subject'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Subject': subject,
    };
  }
}

class MatchmakingData {
  String queueID;
  List<String> preferredGamePods;
  int skillDisparityRRPenalty;

  MatchmakingData({
    required this.queueID,
    required this.preferredGamePods,
    required this.skillDisparityRRPenalty,
  });

  factory MatchmakingData.fromJson(Map<String, dynamic> json) {
    return MatchmakingData(
      queueID: json['QueueID'],
      preferredGamePods: List<String>.from(json['PreferredGamePods']),
      skillDisparityRRPenalty: json['SkillDisparityRRPenalty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'QueueID': queueID,
      'PreferredGamePods': List<dynamic>.from(preferredGamePods.map((x) => x)),
      'SkillDisparityRRPenalty': skillDisparityRRPenalty,
    };
  }
}

class ErrorNotification {
  String errorType;
  List<Participant>? erroredPlayers;

  ErrorNotification({
    required this.errorType,
    this.erroredPlayers,
  });

  factory ErrorNotification.fromJson(Map<String, dynamic> json) {
    return ErrorNotification(
      errorType: json['ErrorType'],
      erroredPlayers: json['ErroredPlayers'] != null
          ? List<Participant>.from(
              json['ErroredPlayers'].map((x) => Participant.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ErrorType': errorType,
      'ErroredPlayers': erroredPlayers != null
          ? List<dynamic>.from(erroredPlayers!.map((x) => x.toJson()))
          : null,
    };
  }
}

class CheatData {
  String gamePodOverride;
  bool forcePostGameProcessing;

  CheatData({
    required this.gamePodOverride,
    required this.forcePostGameProcessing,
  });

  factory CheatData.fromJson(Map<String, dynamic> json) {
    return CheatData(
      gamePodOverride: json['GamePodOverride'],
      forcePostGameProcessing: json['ForcePostGameProcessing'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'GamePodOverride': gamePodOverride,
      'ForcePostGameProcessing': forcePostGameProcessing,
    };
  }
}

class PartyPlayerResponse {
  String subject;
  int version;
  String currentPartyID;
  dynamic invites;
  List<Request> requests;
  PlatformInfo platformInfo;

  PartyPlayerResponse({
    required this.subject,
    required this.version,
    required this.currentPartyID,
    required this.invites,
    required this.requests,
    required this.platformInfo,
  });

  factory PartyPlayerResponse.fromJson(Map<String, dynamic> json) {
    return PartyPlayerResponse(
      subject: json['Subject'],
      version: json['Version'],
      currentPartyID: json['CurrentPartyID'],
      invites: json['Invites'],
      requests:
          List<Request>.from(json['Requests'].map((x) => Request.fromJson(x))),
      platformInfo: PlatformInfo.fromJson(json['PlatformInfo']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Subject': subject,
      'Version': version,
      'CurrentPartyID': currentPartyID,
      'Invites': invites,
      'Requests': List<dynamic>.from(requests.map((x) => x.toJson())),
      'PlatformInfo': platformInfo.toJson(),
    };
  }
}

class Request {
  String id;
  String partyID;
  String requestedBySubject;
  List<String> subjects;
  String createdAt;
  String refreshedAt;
  int expiresIn;

  Request({
    required this.id,
    required this.partyID,
    required this.requestedBySubject,
    required this.subjects,
    required this.createdAt,
    required this.refreshedAt,
    required this.expiresIn,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json['ID'],
      partyID: json['PartyID'],
      requestedBySubject: json['RequestedBySubject'],
      subjects: List<String>.from(json['Subjects']),
      createdAt: json['CreatedAt'],
      refreshedAt: json['RefreshedAt'],
      expiresIn: json['ExpiresIn'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'PartyID': partyID,
      'RequestedBySubject': requestedBySubject,
      'Subjects': List<dynamic>.from(subjects.map((x) => x)),
      'CreatedAt': createdAt,
      'RefreshedAt': refreshedAt,
      'ExpiresIn': expiresIn,
    };
  }
}

class PlatformInfo {
  String platformType;
  String platformOS;
  String platformOSVersion;
  String platformChipset;

  PlatformInfo({
    required this.platformType,
    required this.platformOS,
    required this.platformOSVersion,
    required this.platformChipset,
  });

  factory PlatformInfo.fromJson(Map<String, dynamic> json) {
    return PlatformInfo(
      platformType: json['platformType'],
      platformOS: json['platformOS'],
      platformOSVersion: json['platformOSVersion'],
      platformChipset: json['platformChipset'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'platformType': platformType,
      'platformOS': platformOS,
      'platformOSVersion': platformOSVersion,
      'platformChipset': platformChipset,
    };
  }
}
