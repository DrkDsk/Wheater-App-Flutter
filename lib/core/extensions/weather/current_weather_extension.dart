import 'package:clima_app/features/home/domain/entities/current.dart';

extension CurrentWeatherExtension on Current {
  double get tempCelsius => (temp) - 273.15;

  double get feelsLikeCelsius => (feelsLike) - 273.15;

  double get windSpeedKm => (windSpeed * 3.6);

  String get tempCelsiusText => '${tempCelsius.toStringAsFixed(1)}°C';

  String get feelsLikeCelsiusText => '${feelsLikeCelsius.toStringAsFixed(1)}°C';

  String get windSpeedKmText => '$windSpeed km/h';

  String get windDirectionText {
    double speedKmh = windSpeedKm * 3.6;

    final windDegDirection = windDeg;

    if (windDegDirection == null) return "";

    List<String> directions = [
      "Norte",
      "Noreste",
      "Este",
      "Sureste",
      "Sur",
      "Suroeste",
      "Oeste",
      "Noroeste"
    ];

    int index = ((windDegDirection + 22.5) ~/ 45) % 8;

    return "${speedKmh.round()} km/h (${directions[index]})";
  }

  String get visibilityTextInKm =>
      "${((visibility) / 1000).toStringAsFixed(0)} km";
}
