import 'package:clima_app/features/home/data/models/current_model.dart';
import 'package:clima_app/features/home/data/models/daily_model.dart';
import 'package:clima_app/features/home/data/models/hourly_model.dart';
import 'package:clima_app/features/home/domain/entities/forecast.dart';
import 'package:equatable/equatable.dart';

class ForecastModel with EquatableMixin {
  ForecastModel({
    required this.latitude,
    required this.longitude,
    required this.timeZone,
    required this.timezoneOffset,
    required this.current,
    this.hourly,
    this.daily,
  });

  final double latitude;
  final double longitude;
  final String timeZone;
  final int timezoneOffset;
  final CurrentModel current;
  final List<HourlyModel>? hourly;
  final List<DailyModel>? daily;

  factory ForecastModel.fromJson(Map<String, dynamic> map) {
    return ForecastModel(
      latitude: (map['lat'] as num).toDouble(),
      longitude: (map['lon'] as num).toDouble(),
      timeZone: map['timezone'] as String,
      timezoneOffset: (map['timezone_offset'] as num).toInt(),
      current: CurrentModel.fromJson(map["current"]),
      hourly: map["hourly"] == null
          ? null
          : List<HourlyModel>.from(
              map["hourly"]!.map((x) => HourlyModel.fromJson(x))),
      daily: map["daily"] == null
          ? null
          : List<DailyModel>.from(
              map["daily"]!.map((x) => DailyModel.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "lat": latitude,
        "lon": longitude,
        "timezone": timeZone,
        "timezone_offset": timezoneOffset,
        "current": current.toJson(),
        "hourly": hourly?.map((x) => (x).toJson()).toList(),
        "daily": daily?.map((x) => (x).toJson()).toList()
      };

  Forecast toEntity() {
    return Forecast(
      latitude: latitude,
      longitude: longitude,
      timeZone: timeZone,
      timezoneOffset: timezoneOffset,
      current: current.toEntity(),
      hourly: hourly?.map((element) => element.toEntity()).toList() ?? [],
      daily: daily?.map((element) => element.toEntity()).toList() ?? [],
    );
  }

  @override
  List<Object?> get props =>
      [latitude, longitude, timeZone, timezoneOffset, current, hourly, daily];
}

extension MapCleaner on Map<String, dynamic> {
  Map<String, dynamic> cleanNulls() {
    final cleaned = <String, dynamic>{};
    forEach((key, value) {
      if (value == null) return;

      if (value is Map<String, dynamic>) {
        final nestedClean = value.cleanNulls();
        if (nestedClean.isNotEmpty) {
          cleaned[key] = nestedClean;
        }
      } else if (value is List) {
        final cleanedList = value.map((item) {
          if (item is Map<String, dynamic>) {
            return item.cleanNulls();
          }
          return item;
        }).where((item) {
          if (item == null) return false;
          if (item is Map && item.isEmpty) return false;
          return true;
        }).toList();

        if (cleanedList.isNotEmpty) {
          cleaned[key] = cleanedList;
        }
      } else {
        cleaned[key] = value;
      }
    });
    return cleaned;
  }
}
