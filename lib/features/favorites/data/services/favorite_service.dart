import 'package:clima_app/features/favorites/data/datasources/favorite_datasource.dart';

class LocationMapper {
  const LocationMapper({
    required FavoriteDataSource favoriteDataSource,
  });

  static double roundCoordinate(double value) =>
      double.parse(value.toStringAsFixed(3));
}
