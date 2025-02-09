class Coordinates {
  final double lat, lng;
  const Coordinates({required this.lat, required this.lng});

  factory Coordinates.fromJson(Map<String, dynamic> json) => Coordinates(
      lat: double.parse(json['lat'].toString()),
      lng: double.parse(json['lng'].toString()));
}
