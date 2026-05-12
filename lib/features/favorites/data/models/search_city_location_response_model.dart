import 'package:clima_app/core/error/exceptions/unknown_exception.dart';
import 'package:clima_app/features/favorites/data/models/city_location_model.dart';
import 'package:clima_app/features/city/domain/entities/search_city_location_response.dart';

class SearchCityLocationResponseModel {
  final List<CityLocationModel> data;

  const SearchCityLocationResponseModel({required this.data});

  factory SearchCityLocationResponseModel.fromJson(List<dynamic> jsonList) {
    try {
      return SearchCityLocationResponseModel(
        data: jsonList.map((json) => CityLocationModel.fromMap(json)).toList(),
      );
    } catch (e) {
      throw UnknownException(message: e.toString());
    }
  }

  SearchCityLocationResponse toEntity() {
    return SearchCityLocationResponse(
      data: data.map((element) => element.toEntity()).toList(),
    );
  }
}
