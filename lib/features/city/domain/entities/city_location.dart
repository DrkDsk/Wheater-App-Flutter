class CityLocation {
  final String? name;
  final double latitude;
  final double longitude;

  const CityLocation({
    this.name,
    required this.latitude,
    required this.longitude,
  });

  CityLocation copyWith({
    String? name,
    double? latitude,
    double? longitude,
  }) {
    return CityLocation(
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
