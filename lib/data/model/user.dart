import 'package:herafy/data/model/location.dart';

abstract class User {
  String? id;
  late String fName, lName, phone, type, status, gender, birthDate;
  late Location location;
  //User({required this.fName, required this.lName, required this.phone});

  User.empty();

  User({
    required this.id,
    required this.type,
    required this.fName,
    required this.lName,
    required this.phone,
    required this.status,
    required this.gender,
    required this.location,
    required this.birthDate,
  });

  User.fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}
