import 'package:herafy/data/model/location.dart';
import 'package:intl/intl.dart';

class Order {
  late Location location;
  late List<String> proposals;
  late String? postedDate;
  late String id, date, description, speciality, status, clientID, clientName;

  Order({
    this.id = "",
    String? postedDate,
    required this.date,
    required this.clientID,
    required this.location,
    this.status = "pending",
    required this.clientName,
    required this.speciality,
    required this.description,
    this.proposals = const [],
  }) : postedDate = postedDate ??
            (DateFormat("YYYY-MM-dd").format(DateTime.now())).toString();

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      date: json['date'],
      status: json['status'],
      clientID: json['clientID'],
      postedDate: json['postedDate'],
      clientName: json['clientName'],
      speciality: json['speciality'],
      description: json['description'],
      proposals: json['proposals'].cast<String>(),
      location: Location.fromJson(json['location']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'status': status,
      'clientID': clientID,
      'proposals': proposals,
      'clientName': clientName,
      'postedDate': postedDate,
      'speciality': speciality,
      'description': description,
      'location': location.toJson(),
    };
  }
}
