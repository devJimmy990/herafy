import 'package:herafy/data/model/location.dart';
import 'package:herafy/data/model/user.dart';

class Client extends User {
  Client.empty() : super.empty();

  Client({
    super.id = '',
    super.type = "client",
    required super.fName,
    required super.lName,
    required super.phone,
    required super.status,
    required super.gender,
    required super.location,
  });
  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
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
