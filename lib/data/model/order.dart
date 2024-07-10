import 'package:herafy/data/model/location.dart';
import 'package:herafy/data/model/technician.dart';
import 'package:intl/intl.dart';

class Order {
  late Location location;
  late List<Technician> proposals;
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
            (DateFormat("yyyy-MM-dd").format(DateTime.now())).toString();

  factory Order.fromJsonClient(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      date: json['date'],
      status: json['status'],
      clientID: json['clientID'],
      postedDate: json['postedDate'],
      clientName: json['clientName'],
      speciality: json['speciality'],
      description: json['description'],
      location: Location.fromJson(json['location']),
      proposals: json['proposals']
          .map<Technician>((e) => Technician.fromJson(e))
          .toList(),
    );
  }
  factory Order.fromJsonTechnician(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      date: json['date'],
      status: json['status'],
      clientID: json['clientID'],
      postedDate: json['postedDate'],
      clientName: json['clientName'],
      speciality: json['speciality'],
      description: json['description'],
      location: Location.fromJson(json['location']),
      // proposals: json['proposals']
      //     .map<Technician>((e) => Technician.fromJson(e))
      //     .toList(),
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
