import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:location/location.dart';

extension LocationDataExtension on LocationData {
  CityLocation toCityLocation() {
    return CityLocation(
        city: "",
        latitude: latitude ?? 0,
        longitude: longitude ?? 0,
        country: "",
        state: "",
        cityName: "");
  }
}
