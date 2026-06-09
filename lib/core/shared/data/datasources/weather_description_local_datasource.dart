import 'dart:convert';
import 'package:clima_app/features/home/domain/entities/translated/translated_weather.dart';
import 'package:flutter/services.dart' show rootBundle;

class WeatherDescriptionLocalDataSourceImpl {
  Future<List<TranslatedWeather>> loadDescriptions() async {
    final String jsonString =
        await rootBundle.loadString('assets/json/weather_descriptions.json');
    final List<dynamic> jsonList = json.decode(jsonString);

    return jsonList
        .map((jsonItem) => TranslatedWeather.fromJson(jsonItem))
        .toList();
  }
}
