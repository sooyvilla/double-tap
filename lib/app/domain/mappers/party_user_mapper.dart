import 'package:double_tap/app/domain/entities/party_user.dart';

import '../../data/models/party_response.dart' as party_data;

PartyUser mapPartyUser(party_data.PartyResponse party) {
  return PartyUser(
    // members: party.members,
    // errorNotification: party.errorNotification,
    // queueName: party.queueName,
  );
}
