import 'package:equatable/equatable.dart';

class WeatherCondition with EquatableMixin {
  WeatherCondition({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  WeatherCondition copyWith({
    int? id,
    String? main,
    String? description,
    String? icon,
  }) {
    return WeatherCondition(
      id: id ?? this.id,
      main: main ?? this.main,
      description: description ?? this.description,
      icon: icon ?? this.icon,
    );
  }

  @override
  List<Object?> get props => [
        id,
        description,
      ];
}
