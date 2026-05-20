import 'package:clima_app/features/home/data/models/rain_model.dart';
import 'package:clima_app/features/home/data/models/weather_condition_model.dart';
import 'package:clima_app/features/home/domain/entities/current.dart';
import 'package:equatable/equatable.dart';

class CurrentModel with EquatableMixin {
  CurrentModel({
    required this.sunrise,
    required this.sunset,
    required this.feelsLike,
    required this.weather,
    required this.visibility,
    required this.dt,
    required this.temp,
    required this.pressure,
    required this.humidity,
    required this.dewPoint,
    required this.uvi,
    required this.clouds,
    required this.windSpeed,
    this.windDeg,
    this.windGust,
    this.rain,
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

  factory CurrentModel.fromJson(Map<String, dynamic> map) {
    return CurrentModel(
      dt: (map['dt'] as num).toInt(),
      sunrise: (map['sunrise'] as num).toInt(),
      sunset: (map['sunset'] as num).toInt(),
      temp: (map['temp'] as num).toDouble(),
      feelsLike: (map['feels_like'] as num).toDouble(),
      pressure: (map['pressure'] as num).toInt(),
      humidity: (map['humidity'] as num).toInt(),
      dewPoint: (map['dew_point'] as num).toDouble(),
      uvi: (map['uvi'] as num).toDouble(),
      clouds: (map['clouds'] as num).toInt(),
      visibility: (map['visibility'] as num).toInt(),
      windSpeed: (map['wind_speed'] as num).toDouble(),
      windDeg: (map['wind_deg'] as num?)?.toInt(),
      windGust: (map['wind_gust'] as num?)?.toDouble(),
      weather: map["weather"] == null
          ? []
          : List<WeatherConditionModel>.from(
              map["weather"]!.map((x) => WeatherConditionModel.fromJson(x))),
      rain: map["rain"] == null ? null : RainModel.fromJson(map["rain"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "dt": dt,
        "sunrise": sunrise,
        "sunset": sunset,
        "temp": temp,
        "feels_like": feelsLike,
        "pressure": pressure,
        "humidity": humidity,
        "dew_point": dewPoint,
        "uvi": uvi,
        "clouds": clouds,
        "visibility": visibility,
        "wind_speed": windSpeed,
        "wind_deg": windDeg,
        "wind_gust": windGust,
        "weather": weather.map((x) => x.toJson()).toList(),
        "rain": rain?.toJson(),
      };

  Current toEntity() {
    return Current(
      dt: dt,
      sunrise: sunrise,
      sunset: sunset,
      temp: temp,
      feelsLike: feelsLike,
      pressure: pressure,
      humidity: humidity,
      dewPoint: dewPoint,
      uvi: uvi,
      clouds: clouds,
      visibility: visibility,
      windSpeed: windSpeed,
      windDeg: windDeg,
      windGust: windGust,
      weather: weather.map((e) => e.toEntity()).toList(),
      rain: rain?.toEntity(),
    );
  }

  @override
  // TODO: implement props
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
        rain
      ];
}
