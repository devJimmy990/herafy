class MessageModel {
  final String message;
  final String receiverId;
  final String senderId;
  final String date;

  MessageModel({
    required this.message,
    required this.receiverId,
    required this.senderId,
    required this.date,
  });

  factory MessageModel.fromJson(json) {
    return MessageModel(
      message: json['message'],
      receiverId: json['receiverId'],
      senderId: json['senderId'],
      date: json['date'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'receiverId': receiverId,
      'senderId': senderId,
      'date': date,
    };
  }
}
