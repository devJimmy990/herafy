import 'package:herafy/data/model/location.dart';
import 'package:herafy/data/model/user.dart';

class Client extends User {
  Client.empty() : super.empty();

  Client({
    super.id = '',
    super.type = "client",
    super.status = "active",
    required super.fName,
    required super.lName,
    required super.phone,
    required super.gender,
    required super.location,
    required super.birthDate,
  });
  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'] ?? 'Not Found',
      type: json['type'] ?? 'Not Found',
      fName: json['fName'] ?? 'Not Found',
      lName: json['lName'] ?? 'Not Found',
      phone: json['phone'] ?? 'Not Found',
      status: json['status'] ?? 'Not Found',
      gender: json['gender'] ?? 'Not Found',
      birthDate: json['birthDate'] ?? 'Not Found',
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
      'location': location.toJson()
    };
  }
}
