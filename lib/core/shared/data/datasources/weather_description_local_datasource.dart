import 'dart:convert';
import 'package:clima_app/features/home/domain/entities/translated/translated_weather.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

class WeatherDescriptionLocalDataSourceImpl {
  Future<List<TranslatedWeather>> loadDescriptions() async {
    final String jsonString =
        await rootBundle.loadString('assets/json/weather_descriptions.json');

    return compute(_parseDescriptions, jsonString);
  }

  List<TranslatedWeather> _parseDescriptions(String jsonString) {
    final List<dynamic> jsonList = json.decode(jsonString);

    return jsonList.map((e) => TranslatedWeather.fromJson(e)).toList();
  }
}
