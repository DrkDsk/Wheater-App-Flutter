import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:clima_app/features/home/domain/entities/forecast.dart';

sealed class WeatherListItem {
  const WeatherListItem();
}

class CurrentLocationItem extends WeatherListItem {
  final Forecast forecast;

  const CurrentLocationItem({required this.forecast});
}

class FavoriteWeatherItem extends WeatherListItem {
  final CityLocation cityLocation;
  final Forecast? forecast;

  const FavoriteWeatherItem({
    required this.cityLocation,
    this.forecast,
  });
}
