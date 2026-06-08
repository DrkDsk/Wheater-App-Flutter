import 'package:clima_app/features/city/domain/entities/city_location.dart';

class WeatherDataToStore {
  final CityLocation cityLocation;
  final bool isAvailableToStore;

  const WeatherDataToStore({
    required this.cityLocation,
    required this.isAvailableToStore,
  });
}
