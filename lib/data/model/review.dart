class Review {
  late int rate;
  late String id, clientID, clientName, description;

  Review({
    this.rate = 0,
    this.id = "",
    this.clientID = "",
    this.clientName = "",
    this.description = "",
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      rate: json['rate'],
      clientID: json['clientID'],
      clientName: json['clientName'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rate': rate,
      'clientID': clientID,
      'clientName': clientName,
      'description': description,
    };
  }
}
