enum QueueID {
  competitive,
  deathmatch,
  // Puedes añadir más tipos de QueueID si es necesario
}

QueueID queueIdFromString(String queueId) {
  switch (queueId) {
    case 'competitive':
      return QueueID.competitive;
    case 'deathmatch':
      return QueueID.deathmatch;
    default:
      throw Exception('Unknown QueueID: $queueId');
  }
}

String queueIdToString(QueueID queueId) {
  switch (queueId) {
    case QueueID.competitive:
      return 'competitive';
    case QueueID.deathmatch:
      return 'deathmatch';
    default:
      throw Exception('Unknown QueueID: $queueId');
  }
}

class Match {
  final String? matchID;
  final int? gameStartTime;
  final QueueID? queueID;

  Match({
    this.matchID,
    this.gameStartTime,
    this.queueID,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      matchID: json['MatchID'],
      gameStartTime: json['GameStartTime'],
      queueID:
          json['QueueID'] != null ? queueIdFromString(json['QueueID']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'MatchID': matchID,
      'GameStartTime': gameStartTime,
      'QueueID': queueID != null ? queueIdToString(queueID!) : null,
    };
  }
}

class MatchHistory {
  final String? subject;
  final int? beginIndex;
  final int? endIndex;
  final int? total;
  final List<Match>? history;

  MatchHistory({
    this.subject,
    this.beginIndex,
    this.endIndex,
    this.total,
    this.history,
  });

  factory MatchHistory.fromJson(Map<String, dynamic> json) {
    return MatchHistory(
        subject: json['Subject'],
        beginIndex: json['BeginIndex'],
        endIndex: json['EndIndex'],
        total: json['Total'],
        history: json['History'] != null
            ? List<Match>.from(
                json['History'].map((item) => Match.fromJson(item)))
            : null,
        );
  }

  Map<String, dynamic> toJson() {
    return {
      'Subject': subject,
      'BeginIndex': beginIndex,
      'EndIndex': endIndex,
      'Total': total,
      'History': history?.map((match) => match.toJson()).toList(),
    };
  }
}
