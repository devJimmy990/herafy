class Location {
  late String area, city, street;
  late double latitude, longitude;

  Location.empty();

  Location(
      {required this.area,
      required this.city,
      required this.street,
      required this.latitude,
      required this.longitude});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      area: json['area'] ?? 'Not Found',
      city: json['city'] ?? 'Not Found',
      street: json['street'] ?? 'Not Found',
      latitude: json['latitude'] ?? 'Not Found',
      longitude: json['longitude'] ?? 'Not Found',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "area": area,
      "city": city,
      "street": street,
      "latitude": latitude,
      "longitude": longitude,
    };
  }
}
