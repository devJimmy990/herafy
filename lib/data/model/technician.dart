import 'package:herafy/data/model/location.dart';
import 'package:herafy/data/model/user.dart';

class Technician extends User {
  late String speciality;
  Technician.empty() : super.empty();

  Technician({
    super.id = '',
    super.status = "pending",
    required super.fName,
    required super.lName,
    required super.phone,
    required super.gender,
    required super.location,
    required super.birthDate,
    super.type = "technician",
    required this.speciality,
  });
  factory Technician.fromJson(Map<String, dynamic> json) {
    return Technician(
      id: json['id'] ?? 'Not Found',
      type: json['type'] ?? 'Not Found',
      fName: json['fName'] ?? 'Not Found',
      lName: json['lName'] ?? 'Not Found',
      phone: json['phone'] ?? 'Not Found',
      status: json['status'] ?? 'Not Found',
      gender: json['gender'] ?? 'Not Found',
      birthDate: json['birthDate'] ?? 'Not Found',
      speciality: json['speciality'] ?? 'Not Found',
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
      'birthDate': birthDate,
      'speciality': speciality,
      'location': location.toJson()
    };
  }
}
