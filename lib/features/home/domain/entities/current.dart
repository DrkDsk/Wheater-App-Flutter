import 'package:clima_app/features/home/data/models/rain_model.dart';
import 'package:clima_app/features/home/data/models/weather_condition_model.dart';
import 'package:equatable/equatable.dart';

class Current with EquatableMixin {
  Current({
    required this.dt,
    required this.sunrise,
    required this.sunset,
    required this.temp,
    required this.feelsLike,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    required this.visibility,
    required this.windSpeed,
    required this.windDeg,
    required this.windGust,
    required this.weather,
    required this.rain,
  });

  final int dt;
  final int sunrise;
  final int sunset;
  final double temp;
  final double feelsLike;
  final int pressure;
  final int humidity;
  final double dewPoint;
  final double uvi;
  final int clouds;
  final int visibility;
  final double windSpeed;
  final int? windDeg;
  final double? windGust;
  final List<WeatherConditionModel> weather;
  final RainModel? rain;

  Current copyWith({
    int? dt,
    int? sunrise,
    int? sunset,
    double? temp,
    double? feelsLike,
    int? pressure,
    int? humidity,
    double? dewPoint,
    double? uvi,
    int? clouds,
    int? visibility,
    double? windSpeed,
    int? windDeg,
    double? windGust,
    List<WeatherConditionModel>? weather,
    RainModel? rain,
  }) {
    return Current(
      dt: dt ?? this.dt,
      sunrise: sunrise ?? this.sunrise,
      sunset: sunset ?? this.sunset,
      temp: temp ?? this.temp,
      feelsLike: feelsLike ?? this.feelsLike,
      pressure: pressure ?? this.pressure,
      humidity: humidity ?? this.humidity,
      dewPoint: dewPoint ?? this.dewPoint,
      uvi: uvi ?? this.uvi,
      clouds: clouds ?? this.clouds,
      visibility: visibility ?? this.visibility,
      windSpeed: windSpeed ?? this.windSpeed,
      windDeg: windDeg ?? this.windDeg,
      windGust: windGust ?? this.windGust,
      weather: weather ?? this.weather,
      rain: rain ?? this.rain,
    );
  }

  @override
  List<Object?> get props => [
        dt,
        sunrise,
        sunset,
        temp,
        feelsLike,
        pressure,
        humidity,
        dewPoint,
        uvi,
        clouds,
        visibility,
        windSpeed,
        windDeg,
        windGust,
        weather,
        rain,
      ];

  Map<String, dynamic> toMap() {
    return {
      'dt': dt,
      'sunrise': sunrise,
      'sunset': sunset,
      'temp': temp,
      'feelsLike': feelsLike,
      'pressure': pressure,
      'humidity': humidity,
      'dewPoint': dewPoint,
      'uvi': uvi,
      'clouds': clouds,
      'visibility': visibility,
      'windSpeed': windSpeed,
      'windDeg': windDeg,
      'windGust': windGust,
      'weather': weather,
      'rain': rain,
    };
  }
}
