import 'package:clima_app/features/city/domain/entities/city_location.dart';

class SearchCityLocationResponse {
  final List<CityLocation> data;

  const SearchCityLocationResponse({required this.data});
}
