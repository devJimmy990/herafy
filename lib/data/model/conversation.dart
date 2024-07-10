class ConversationModel {
  final String id;
  final String client;
  final String lastUpdatedAt;

  final Map technician;
  final List participantsIds;
  String lastMessages;

  ConversationModel({
    required this.id,
    required this.lastUpdatedAt,
    required this.participantsIds,
    required this.lastMessages,
    required this.client,
    required this.technician,
  });

  factory ConversationModel.fromJson(json) {
    return ConversationModel(
      id: json['id'],
      lastUpdatedAt: json['lastUpdatedAt'],
      participantsIds: json['participantsIds'],
      lastMessages: json['lastMessages'],
      client: json['client'],
      technician: json['technician'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lastUpdatedAt': lastUpdatedAt,
      'participantsIds': participantsIds,
      'lastMessages': lastMessages,
    };
  }
}
