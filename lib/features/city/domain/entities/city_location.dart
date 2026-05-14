class CityLocation {
  final String? name;
  final double latitude;
  final double longitude;
  final String timestamp;
  final bool isStored;

  const CityLocation({
    this.name,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
    this.isStored = false,
  });

  CityLocation copyWith({
    String? name,
    double? latitude,
    double? longitude,
    String? timestamp,
    bool? isStored,
  }) {
    return CityLocation(
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      timestamp: timestamp ?? this.timestamp,
      isStored: isStored ?? this.isStored,
    );
  }
}
