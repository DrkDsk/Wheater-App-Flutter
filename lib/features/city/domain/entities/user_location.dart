import 'package:clima_app/features/home/domain/entities/coordinate.dart';
import 'package:equatable/equatable.dart';

class UserLocation extends Coordinate with EquatableMixin {
  final DateTime timestamp;

  UserLocation({
    required super.latitude,
    required super.longitude,
    required this.timestamp,
  });

  @override
  List<Object?> get props => [latitude, longitude];

  UserLocation copyWith({
    DateTime? timestamp,
    double? latitude,
    double? longitude,
  }) {
    return UserLocation(
      timestamp: timestamp ?? this.timestamp,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}
