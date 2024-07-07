class Location {
  late String area, city, country;
  late double latitude, longitude;

  Location.empty();

  Location(
      {required this.area,
      required this.city,
      required this.country,
      required this.latitude,
      required this.longitude});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      area: json['area'],
      city: json['city'],
      country: json['country'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "area": area,
      "city": city,
      "country": country,
      "latitude": latitude,
      "longitude": longitude,
    };
  }
}
