import 'package:clima_app/features/favorites/data/datasources/favorite_weather_datasource.dart';

class LocationMapper {
  const LocationMapper({
    required FavoriteWeatherDataSource favoriteDataSource,
  });

  static double roundCoordinate(double value) =>
      double.parse(value.toStringAsFixed(3));
}
