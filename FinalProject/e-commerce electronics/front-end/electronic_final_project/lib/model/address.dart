class Address {
  late double latitude;
  late double longitude;
  late String country;
  late String city;
  late String area;
  late String street;
  late String buildingNo;

  Address({
    required this.latitude,
    required this.longitude,
    required this.country,
    required this.city,
    required this.area,
    required this.street,
    required this.buildingNo,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      latitude: json['latitude'] ?? 0.0,
      longitude: json['longitude'] ?? 0.0,
      country: json['country'] ?? '',
      city: json['city'] ?? '',
      area: json['area'] ?? '',
      street: json['street'] ?? '',
      buildingNo: json['building_no'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "country": country,
        "city": city,
        "area": area,
        "street": street,
        "building_no": buildingNo,
      };
}
