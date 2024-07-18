import 'dart:convert';

class PartyResponse {
  final String? id;
  final String? mucName;
  final String? voiceRoomId;
  final int? version;
  final String? clientVersion;
  final List<Member>? members;
  final String? state;
  final String? previousState;
  final String? stateTransitionReason;
  final String? accessibility;
  final CustomGameData? customGameData;
  final MatchmakingData? matchmakingData;
  final dynamic invites;
  final List<dynamic>? requests;
  final String? queueEntryTime;
  final ErrorNotification? errorNotification;
  final int? restrictedSeconds;
  final List<String>? eligibleQueues;
  final List<String>? queueIneligibilities;
  final CheatData? cheatData;
  final List<dynamic>? xpBonuses;
  final String? inviteCode;

  PartyResponse({
    this.id,
    this.mucName,
    this.voiceRoomId,
    this.version,
    this.clientVersion,
    this.members,
    this.state,
    this.previousState,
    this.stateTransitionReason,
    this.accessibility,
    this.customGameData,
    this.matchmakingData,
    this.invites,
    this.requests,
    this.queueEntryTime,
    this.errorNotification,
    this.restrictedSeconds,
    this.eligibleQueues,
    this.queueIneligibilities,
    this.cheatData,
    this.xpBonuses,
    this.inviteCode,
  });

  PartyResponse copyWith({
    String? id,
    String? mucName,
    String? voiceRoomId,
    int? version,
    String? clientVersion,
    List<Member>? members,
    String? state,
    String? previousState,
    String? stateTransitionReason,
    String? accessibility,
    CustomGameData? customGameData,
    MatchmakingData? matchmakingData,
    dynamic invites,
    List<dynamic>? requests,
    String? queueEntryTime,
    ErrorNotification? errorNotification,
    int? restrictedSeconds,
    List<String>? eligibleQueues,
    List<String>? queueIneligibilities,
    CheatData? cheatData,
    List<dynamic>? xpBonuses,
    String? inviteCode,
  }) =>
      PartyResponse(
        id: id ?? this.id,
        mucName: mucName ?? this.mucName,
        voiceRoomId: voiceRoomId ?? this.voiceRoomId,
        version: version ?? this.version,
        clientVersion: clientVersion ?? this.clientVersion,
        members: members ?? this.members,
        state: state ?? this.state,
        previousState: previousState ?? this.previousState,
        stateTransitionReason:
            stateTransitionReason ?? this.stateTransitionReason,
        accessibility: accessibility ?? this.accessibility,
        customGameData: customGameData ?? this.customGameData,
        matchmakingData: matchmakingData ?? this.matchmakingData,
        invites: invites ?? this.invites,
        requests: requests ?? this.requests,
        queueEntryTime: queueEntryTime ?? this.queueEntryTime,
        errorNotification: errorNotification ?? this.errorNotification,
        restrictedSeconds: restrictedSeconds ?? this.restrictedSeconds,
        eligibleQueues: eligibleQueues ?? this.eligibleQueues,
        queueIneligibilities: queueIneligibilities ?? this.queueIneligibilities,
        cheatData: cheatData ?? this.cheatData,
        xpBonuses: xpBonuses ?? this.xpBonuses,
        inviteCode: inviteCode ?? this.inviteCode,
      );

  factory PartyResponse.fromRawJson(String str) =>
      PartyResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PartyResponse.fromJson(Map<String, dynamic> json) => PartyResponse(
        id: json['ID'],
        mucName: json['MUCName'],
        voiceRoomId: json['VoiceRoomID'],
        version: json['Version'],
        clientVersion: json['ClientVersion'],
        members: json['Members'] == null
            ? []
            : List<Member>.from(
                json['Members']!.map((x) => Member.fromJson(x))),
        state: json['State'],
        previousState: json['PreviousState'],
        stateTransitionReason: json['StateTransitionReason'],
        accessibility: json['Accessibility'],
        customGameData: json['CustomGameData'] == null
            ? null
            : CustomGameData.fromJson(json['CustomGameData']),
        matchmakingData: json['MatchmakingData'] == null
            ? null
            : MatchmakingData.fromJson(json['MatchmakingData']),
        invites: json['Invites'],
        requests: json['Requests'] == null
            ? []
            : List<dynamic>.from(json['Requests']!.map((x) => x)),
        queueEntryTime: json['QueueEntryTime'],
        errorNotification: json['ErrorNotification'] == null
            ? null
            : ErrorNotification.fromJson(json['ErrorNotification']),
        restrictedSeconds: json['RestrictedSeconds'],
        eligibleQueues: json['EligibleQueues'] == null
            ? []
            : List<String>.from(json['EligibleQueues']!.map((x) => x)),
        queueIneligibilities: json['QueueIneligibilities'] == null
            ? []
            : List<String>.from(json['QueueIneligibilities']!.map((x) => x)),
        cheatData: json['CheatData'] == null
            ? null
            : CheatData.fromJson(json['CheatData']),
        xpBonuses: json['XPBonuses'] == null
            ? []
            : List<dynamic>.from(json['XPBonuses']!.map((x) => x)),
        inviteCode: json['InviteCode'],
      );

  Map<String, dynamic> toJson() => {
        'ID': id,
        'MUCName': mucName,
        'VoiceRoomID': voiceRoomId,
        'Version': version,
        'ClientVersion': clientVersion,
        'Members': members == null
            ? []
            : List<dynamic>.from(members!.map((x) => x.toJson())),
        'State': state,
        'PreviousState': previousState,
        'StateTransitionReason': stateTransitionReason,
        'Accessibility': accessibility,
        'CustomGameData': customGameData?.toJson(),
        'MatchmakingData': matchmakingData?.toJson(),
        'Invites': invites,
        'Requests':
            requests == null ? [] : List<dynamic>.from(requests!.map((x) => x)),
        'QueueEntryTime': queueEntryTime,
        'ErrorNotification': errorNotification?.toJson(),
        'RestrictedSeconds': restrictedSeconds,
        'EligibleQueues': eligibleQueues == null
            ? []
            : List<dynamic>.from(eligibleQueues!.map((x) => x)),
        'QueueIneligibilities': queueIneligibilities == null
            ? []
            : List<dynamic>.from(queueIneligibilities!.map((x) => x)),
        'CheatData': cheatData?.toJson(),
        'XPBonuses': xpBonuses == null
            ? []
            : List<dynamic>.from(xpBonuses!.map((x) => x)),
        'InviteCode': inviteCode,
      };
}

class CheatData {
  final String? gamePodOverride;
  final bool? forcePostGameProcessing;

  CheatData({
    this.gamePodOverride,
    this.forcePostGameProcessing,
  });

  CheatData copyWith({
    String? gamePodOverride,
    bool? forcePostGameProcessing,
  }) =>
      CheatData(
        gamePodOverride: gamePodOverride ?? this.gamePodOverride,
        forcePostGameProcessing:
            forcePostGameProcessing ?? this.forcePostGameProcessing,
      );

  factory CheatData.fromRawJson(String str) =>
      CheatData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CheatData.fromJson(Map<String, dynamic> json) => CheatData(
        gamePodOverride: json['GamePodOverride'],
        forcePostGameProcessing: json['ForcePostGameProcessing'],
      );

  Map<String, dynamic> toJson() => {
        'GamePodOverride': gamePodOverride,
        'ForcePostGameProcessing': forcePostGameProcessing,
      };
}

class CustomGameData {
  final Settings? settings;
  final Membership? membership;
  final int? maxPartySize;
  final bool? autobalanceEnabled;
  final int? autobalanceMinPlayers;
  final bool? hasRecoveryData;

  CustomGameData({
    this.settings,
    this.membership,
    this.maxPartySize,
    this.autobalanceEnabled,
    this.autobalanceMinPlayers,
    this.hasRecoveryData,
  });

  CustomGameData copyWith({
    Settings? settings,
    Membership? membership,
    int? maxPartySize,
    bool? autobalanceEnabled,
    int? autobalanceMinPlayers,
    bool? hasRecoveryData,
  }) =>
      CustomGameData(
        settings: settings ?? this.settings,
        membership: membership ?? this.membership,
        maxPartySize: maxPartySize ?? this.maxPartySize,
        autobalanceEnabled: autobalanceEnabled ?? this.autobalanceEnabled,
        autobalanceMinPlayers:
            autobalanceMinPlayers ?? this.autobalanceMinPlayers,
        hasRecoveryData: hasRecoveryData ?? this.hasRecoveryData,
      );

  factory CustomGameData.fromRawJson(String str) =>
      CustomGameData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomGameData.fromJson(Map<String, dynamic> json) => CustomGameData(
        settings: json['Settings'] == null
            ? null
            : Settings.fromJson(json['Settings']),
        membership: json['Membership'] == null
            ? null
            : Membership.fromJson(json['Membership']),
        maxPartySize: json['MaxPartySize'],
        autobalanceEnabled: json['AutobalanceEnabled'],
        autobalanceMinPlayers: json['AutobalanceMinPlayers'],
        hasRecoveryData: json['HasRecoveryData'],
      );

  Map<String, dynamic> toJson() => {
        'Settings': settings?.toJson(),
        'Membership': membership?.toJson(),
        'MaxPartySize': maxPartySize,
        'AutobalanceEnabled': autobalanceEnabled,
        'AutobalanceMinPlayers': autobalanceMinPlayers,
        'HasRecoveryData': hasRecoveryData,
      };
}

class Membership {
  final List<ErroredPlayer>? teamOne;
  final List<ErroredPlayer>? teamTwo;
  final List<ErroredPlayer>? teamSpectate;
  final List<ErroredPlayer>? teamOneCoaches;
  final List<ErroredPlayer>? teamTwoCoaches;

  Membership({
    this.teamOne,
    this.teamTwo,
    this.teamSpectate,
    this.teamOneCoaches,
    this.teamTwoCoaches,
  });

  Membership copyWith({
    List<ErroredPlayer>? teamOne,
    List<ErroredPlayer>? teamTwo,
    List<ErroredPlayer>? teamSpectate,
    List<ErroredPlayer>? teamOneCoaches,
    List<ErroredPlayer>? teamTwoCoaches,
  }) =>
      Membership(
        teamOne: teamOne ?? this.teamOne,
        teamTwo: teamTwo ?? this.teamTwo,
        teamSpectate: teamSpectate ?? this.teamSpectate,
        teamOneCoaches: teamOneCoaches ?? this.teamOneCoaches,
        teamTwoCoaches: teamTwoCoaches ?? this.teamTwoCoaches,
      );

  factory Membership.fromRawJson(String str) =>
      Membership.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Membership.fromJson(Map<String, dynamic> json) => Membership(
        teamOne: json['teamOne'] == null
            ? []
            : List<ErroredPlayer>.from(
                json['teamOne']!.map((x) => ErroredPlayer.fromJson(x))),
        teamTwo: json['teamTwo'] == null
            ? []
            : List<ErroredPlayer>.from(
                json['teamTwo']!.map((x) => ErroredPlayer.fromJson(x))),
        teamSpectate: json['teamSpectate'] == null
            ? []
            : List<ErroredPlayer>.from(
                json['teamSpectate']!.map((x) => ErroredPlayer.fromJson(x))),
        teamOneCoaches: json['teamOneCoaches'] == null
            ? []
            : List<ErroredPlayer>.from(
                json['teamOneCoaches']!.map((x) => ErroredPlayer.fromJson(x))),
        teamTwoCoaches: json['teamTwoCoaches'] == null
            ? []
            : List<ErroredPlayer>.from(
                json['teamTwoCoaches']!.map((x) => ErroredPlayer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'teamOne': teamOne == null
            ? []
            : List<dynamic>.from(teamOne!.map((x) => x.toJson())),
        'teamTwo': teamTwo == null
            ? []
            : List<dynamic>.from(teamTwo!.map((x) => x.toJson())),
        'teamSpectate': teamSpectate == null
            ? []
            : List<dynamic>.from(teamSpectate!.map((x) => x.toJson())),
        'teamOneCoaches': teamOneCoaches == null
            ? []
            : List<dynamic>.from(teamOneCoaches!.map((x) => x.toJson())),
        'teamTwoCoaches': teamTwoCoaches == null
            ? []
            : List<dynamic>.from(teamTwoCoaches!.map((x) => x.toJson())),
      };
}

class ErroredPlayer {
  final String? subject;

  ErroredPlayer({
    this.subject,
  });

  ErroredPlayer copyWith({
    String? subject,
  }) =>
      ErroredPlayer(
        subject: subject ?? this.subject,
      );

  factory ErroredPlayer.fromRawJson(String str) =>
      ErroredPlayer.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ErroredPlayer.fromJson(Map<String, dynamic> json) => ErroredPlayer(
        subject: json['Subject'],
      );

  Map<String, dynamic> toJson() => {
        'Subject': subject,
      };
}

class Settings {
  final String? map;
  final String? mode;
  final bool? useBots;
  final String? gamePod;
  final GameRules? gameRules;

  Settings({
    this.map,
    this.mode,
    this.useBots,
    this.gamePod,
    this.gameRules,
  });

  Settings copyWith({
    String? map,
    String? mode,
    bool? useBots,
    String? gamePod,
    GameRules? gameRules,
  }) =>
      Settings(
        map: map ?? this.map,
        mode: mode ?? this.mode,
        useBots: useBots ?? this.useBots,
        gamePod: gamePod ?? this.gamePod,
        gameRules: gameRules ?? this.gameRules,
      );

  factory Settings.fromRawJson(String str) =>
      Settings.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
        map: json['Map'],
        mode: json['Mode'],
        useBots: json['UseBots'],
        gamePod: json['GamePod'],
        gameRules: json['GameRules'] == null
            ? null
            : GameRules.fromJson(json['GameRules']),
      );

  Map<String, dynamic> toJson() => {
        'Map': map,
        'Mode': mode,
        'UseBots': useBots,
        'GamePod': gamePod,
        'GameRules': gameRules?.toJson(),
      };
}

class GameRules {
  final String? allowGameModifiers;
  final String? isOvertimeWinByTwo;
  final String? playOutAllRounds;
  final String? skipMatchHistory;
  final String? tournamentMode;

  GameRules({
    this.allowGameModifiers,
    this.isOvertimeWinByTwo,
    this.playOutAllRounds,
    this.skipMatchHistory,
    this.tournamentMode,
  });

  GameRules copyWith({
    String? allowGameModifiers,
    String? isOvertimeWinByTwo,
    String? playOutAllRounds,
    String? skipMatchHistory,
    String? tournamentMode,
  }) =>
      GameRules(
        allowGameModifiers: allowGameModifiers ?? this.allowGameModifiers,
        isOvertimeWinByTwo: isOvertimeWinByTwo ?? this.isOvertimeWinByTwo,
        playOutAllRounds: playOutAllRounds ?? this.playOutAllRounds,
        skipMatchHistory: skipMatchHistory ?? this.skipMatchHistory,
        tournamentMode: tournamentMode ?? this.tournamentMode,
      );

  factory GameRules.fromRawJson(String str) =>
      GameRules.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GameRules.fromJson(Map<String, dynamic> json) => GameRules(
        allowGameModifiers: json['AllowGameModifiers'],
        isOvertimeWinByTwo: json['IsOvertimeWinByTwo'],
        playOutAllRounds: json['PlayOutAllRounds'],
        skipMatchHistory: json['SkipMatchHistory'],
        tournamentMode: json['TournamentMode'],
      );

  Map<String, dynamic> toJson() => {
        'AllowGameModifiers': allowGameModifiers,
        'IsOvertimeWinByTwo': isOvertimeWinByTwo,
        'PlayOutAllRounds': playOutAllRounds,
        'SkipMatchHistory': skipMatchHistory,
        'TournamentMode': tournamentMode,
      };
}

class ErrorNotification {
  final String? errorType;
  final List<ErroredPlayer>? erroredPlayers;

  ErrorNotification({
    this.errorType,
    this.erroredPlayers,
  });

  ErrorNotification copyWith({
    String? errorType,
    List<ErroredPlayer>? erroredPlayers,
  }) =>
      ErrorNotification(
        errorType: errorType ?? this.errorType,
        erroredPlayers: erroredPlayers ?? this.erroredPlayers,
      );

  factory ErrorNotification.fromRawJson(String str) =>
      ErrorNotification.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ErrorNotification.fromJson(Map<String, dynamic> json) =>
      ErrorNotification(
        errorType: json['ErrorType'],
        erroredPlayers: json['ErroredPlayers'] == null
            ? []
            : List<ErroredPlayer>.from(
                json['ErroredPlayers']!.map((x) => ErroredPlayer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        'ErrorType': errorType,
        'ErroredPlayers': erroredPlayers == null
            ? []
            : List<dynamic>.from(erroredPlayers!.map((x) => x.toJson())),
      };
}

class MatchmakingData {
  final String? queueId;
  final List<String>? preferredGamePods;
  final int? skillDisparityRrPenalty;

  MatchmakingData({
    this.queueId,
    this.preferredGamePods,
    this.skillDisparityRrPenalty,
  });

  MatchmakingData copyWith({
    String? queueId,
    List<String>? preferredGamePods,
    int? skillDisparityRrPenalty,
  }) =>
      MatchmakingData(
        queueId: queueId ?? this.queueId,
        preferredGamePods: preferredGamePods ?? this.preferredGamePods,
        skillDisparityRrPenalty:
            skillDisparityRrPenalty ?? this.skillDisparityRrPenalty,
      );

  factory MatchmakingData.fromRawJson(String str) =>
      MatchmakingData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory MatchmakingData.fromJson(Map<String, dynamic> json) =>
      MatchmakingData(
        queueId: json['QueueID'],
        preferredGamePods: json['PreferredGamePods'] == null
            ? []
            : List<String>.from(json['PreferredGamePods']!.map((x) => x)),
        skillDisparityRrPenalty: json['SkillDisparityRRPenalty'],
      );

  Map<String, dynamic> toJson() => {
        'QueueID': queueId,
        'PreferredGamePods': preferredGamePods == null
            ? []
            : List<dynamic>.from(preferredGamePods!.map((x) => x)),
        'SkillDisparityRRPenalty': skillDisparityRrPenalty,
      };
}

class Member {
  final String? subject;
  final int? competitiveTier;
  final PlayerIdentity? playerIdentity;
  final dynamic seasonalBadgeInfo;
  final bool? isOwner;
  final int? queueEligibleRemainingAccountLevels;
  final List<Ping>? pings;
  final bool? isReady;
  final bool? isModerator;
  final bool? useBroadcastHud;
  final String? platformType;

  Member({
    this.subject,
    this.competitiveTier,
    this.playerIdentity,
    this.seasonalBadgeInfo,
    this.isOwner,
    this.queueEligibleRemainingAccountLevels,
    this.pings,
    this.isReady,
    this.isModerator,
    this.useBroadcastHud,
    this.platformType,
  });

  Member copyWith({
    String? subject,
    int? competitiveTier,
    PlayerIdentity? playerIdentity,
    dynamic seasonalBadgeInfo,
    bool? isOwner,
    int? queueEligibleRemainingAccountLevels,
    List<Ping>? pings,
    bool? isReady,
    bool? isModerator,
    bool? useBroadcastHud,
    String? platformType,
  }) =>
      Member(
        subject: subject ?? this.subject,
        competitiveTier: competitiveTier ?? this.competitiveTier,
        playerIdentity: playerIdentity ?? this.playerIdentity,
        seasonalBadgeInfo: seasonalBadgeInfo ?? this.seasonalBadgeInfo,
        isOwner: isOwner ?? this.isOwner,
        queueEligibleRemainingAccountLevels:
            queueEligibleRemainingAccountLevels ??
                this.queueEligibleRemainingAccountLevels,
        pings: pings ?? this.pings,
        isReady: isReady ?? this.isReady,
        isModerator: isModerator ?? this.isModerator,
        useBroadcastHud: useBroadcastHud ?? this.useBroadcastHud,
        platformType: platformType ?? this.platformType,
      );

  factory Member.fromRawJson(String str) => Member.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        subject: json['Subject'],
        competitiveTier: json['CompetitiveTier'],
        playerIdentity: json['PlayerIdentity'] == null
            ? null
            : PlayerIdentity.fromJson(json['PlayerIdentity']),
        seasonalBadgeInfo: json['SeasonalBadgeInfo'],
        isOwner: json['IsOwner'],
        queueEligibleRemainingAccountLevels:
            json['QueueEligibleRemainingAccountLevels'],
        pings: json['Pings'] == null
            ? []
            : List<Ping>.from(json['Pings']!.map((x) => Ping.fromJson(x))),
        isReady: json['IsReady'],
        isModerator: json['IsModerator'],
        useBroadcastHud: json['UseBroadcastHUD'],
        platformType: json['PlatformType'],
      );

  Map<String, dynamic> toJson() => {
        'Subject': subject,
        'CompetitiveTier': competitiveTier,
        'PlayerIdentity': playerIdentity?.toJson(),
        'SeasonalBadgeInfo': seasonalBadgeInfo,
        'IsOwner': isOwner,
        'QueueEligibleRemainingAccountLevels':
            queueEligibleRemainingAccountLevels,
        'Pings': pings == null
            ? []
            : List<dynamic>.from(pings!.map((x) => x.toJson())),
        'IsReady': isReady,
        'IsModerator': isModerator,
        'UseBroadcastHUD': useBroadcastHud,
        'PlatformType': platformType,
      };
}

class Ping {
  final int? ping;
  final String? gamePodId;

  Ping({
    this.ping,
    this.gamePodId,
  });

  Ping copyWith({
    int? ping,
    String? gamePodId,
  }) =>
      Ping(
        ping: ping ?? this.ping,
        gamePodId: gamePodId ?? this.gamePodId,
      );

  factory Ping.fromRawJson(String str) => Ping.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Ping.fromJson(Map<String, dynamic> json) => Ping(
        ping: json['Ping'],
        gamePodId: json['GamePodID'],
      );

  Map<String, dynamic> toJson() => {
        'Ping': ping,
        'GamePodID': gamePodId,
      };
}

class PlayerIdentity {
  final String? subject;
  final String? playerCardId;
  final String? playerTitleId;
  final int? accountLevel;
  final String? preferredLevelBorderId;
  final bool? incognito;
  final bool? hideAccountLevel;

  PlayerIdentity({
    this.subject,
    this.playerCardId,
    this.playerTitleId,
    this.accountLevel,
    this.preferredLevelBorderId,
    this.incognito,
    this.hideAccountLevel,
  });

  PlayerIdentity copyWith({
    String? subject,
    String? playerCardId,
    String? playerTitleId,
    int? accountLevel,
    String? preferredLevelBorderId,
    bool? incognito,
    bool? hideAccountLevel,
  }) =>
      PlayerIdentity(
        subject: subject ?? this.subject,
        playerCardId: playerCardId ?? this.playerCardId,
        playerTitleId: playerTitleId ?? this.playerTitleId,
        accountLevel: accountLevel ?? this.accountLevel,
        preferredLevelBorderId:
            preferredLevelBorderId ?? this.preferredLevelBorderId,
        incognito: incognito ?? this.incognito,
        hideAccountLevel: hideAccountLevel ?? this.hideAccountLevel,
      );

  factory PlayerIdentity.fromRawJson(String str) =>
      PlayerIdentity.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlayerIdentity.fromJson(Map<String, dynamic> json) => PlayerIdentity(
        subject: json['Subject'],
        playerCardId: json['PlayerCardID'],
        playerTitleId: json['PlayerTitleID'],
        accountLevel: json['AccountLevel'],
        preferredLevelBorderId: json['PreferredLevelBorderID'],
        incognito: json['Incognito'],
        hideAccountLevel: json['HideAccountLevel'],
      );

  Map<String, dynamic> toJson() => {
        'Subject': subject,
        'PlayerCardID': playerCardId,
        'PlayerTitleID': playerTitleId,
        'AccountLevel': accountLevel,
        'PreferredLevelBorderID': preferredLevelBorderId,
        'Incognito': incognito,
        'HideAccountLevel': hideAccountLevel,
      };
}
