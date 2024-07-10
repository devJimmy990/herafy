class ConversationModel {
  final String id;

  final String lastUpdatedAt;
  final List participantsIds;
  String lastMessages;

  ConversationModel({
    required this.id,
    required this.lastUpdatedAt,
    required this.participantsIds,
    required this.lastMessages,
  });

  factory ConversationModel.fromJson(json) {
    return ConversationModel(
      id: json['id'],
      lastUpdatedAt: json['lastUpdatedAt'],
      participantsIds: json['participantsIds'],
      lastMessages: json['lastMessages'],
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
