import 'package:equatable/equatable.dart';

class Coordinate with EquatableMixin {
  final double latitude;
  final double longitude;

  Coordinate({required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [latitude, longitude];
}
