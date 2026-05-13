import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:clima_app/features/home/domain/entities/coordinate.dart';

sealed class WeatherListItem {
  const WeatherListItem();
}

class CurrentLocationItem extends WeatherListItem {
  final Coordinate coordinate;

  const CurrentLocationItem({required this.coordinate});
}

class FavoriteWeatherItem extends WeatherListItem {
  final CityLocation cityLocation;

  const FavoriteWeatherItem({
    required this.cityLocation,
  });
}
