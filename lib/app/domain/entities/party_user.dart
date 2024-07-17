// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:double_tap/app/data/models/party.dart';

class PartyUser {
  final List<Member>? members;
  final ErrorNotification? errorNotification;
  final String? queueName;
  PartyUser({
    this.members,
    this.errorNotification,
    this.queueName,
  });

  PartyUser copyWith({
    List<Member>? members,
    ErrorNotification? errorNotification,
    String? queueName,
  }) {
    return PartyUser(
      members: members ?? this.members,
      errorNotification: errorNotification ?? this.errorNotification,
      queueName: queueName ?? this.queueName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'members': members?.map((x) => x).toList(),
      'errorNotification': errorNotification,
      'queueName': queueName,
    };
  }

  factory PartyUser.fromJson(Map<String, dynamic> map) {
    return PartyUser(
      members: map['members'] != null
          ? List<Member>.from(
              (map['members'] as List<int>).map<Member?>(
                (x) => Member.fromJson(x as Map<String, dynamic>),
              ),
            )
          : null,
      errorNotification: map['errorNotification'] != null
          ? ErrorNotification.fromJson(
              map['errorNotification'] as Map<String, dynamic>)
          : null,
      queueName: map['queueName'] != null ? map['queueName'] as String : null,
    );
  }
}
