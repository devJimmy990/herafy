import 'package:herafy/data/model/location.dart';
import 'package:herafy/data/model/user.dart';

class Technician extends User {
  Technician.empty() : super.empty();

  Technician({
    super.id,
    super.type = "technician",
    required super.fName,
    required super.lName,
    required super.phone,
    required super.status,
    required super.gender,
    required super.location,
  });
  factory Technician.fromJson(Map<String, dynamic> json) {
    return Technician(
      id: json['id'],
      type: json['type'],
      fName: json['fName'],
      lName: json['lName'],
      phone: json['phone'],
      status: json['status'],
      gender: json['gender'],
      location: Location.fromJson(json['location']),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'fName': fName,
      'lName': lName,
      'phone': phone,
      'status': status,
      'gender': gender,
      'location': location.toJson()
    };
  }
}
