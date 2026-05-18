import 'package:clima_app/features/home/domain/entities/current.dart';
import 'package:clima_app/features/home/domain/entities/daily.dart';
import 'package:clima_app/features/home/domain/entities/hourly.dart';

class Forecast {
  Forecast({
    required this.latitude,
    required this.longitude,
    required this.timeZone,
    required this.timezoneOffset,
    required this.current,
    this.hourly = const [],
    this.daily = const [],
  });

  final double latitude;
  final double longitude;
  final String timeZone;
  final int timezoneOffset;
  final Current current;
  final List<Hourly> hourly;
  final List<Daily> daily;

  Forecast copyWith({
    double? latitude,
    double? longitude,
    String? timeZone,
    int? timezoneOffset,
    Current? current,
    List<Hourly>? hourly,
    List<Daily>? daily,
  }) {
    return Forecast(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        timeZone: timeZone ?? this.timeZone,
        timezoneOffset: timezoneOffset ?? this.timezoneOffset,
        current: current ?? this.current,
        hourly: hourly ?? this.hourly,
        daily: daily ?? this.daily);
  }
}
