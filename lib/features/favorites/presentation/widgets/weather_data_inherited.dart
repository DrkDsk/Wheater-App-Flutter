import 'package:clima_app/features/favorites/domain/entities/weather_data_to_store.dart';
import 'package:flutter/material.dart';

class WeatherDataInherited extends InheritedWidget {
  final WeatherDataToStore? weatherDataToStore;

  const WeatherDataInherited({
    super.key,
    required this.weatherDataToStore,
    required super.child,
  });

  static WeatherDataToStore? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<WeatherDataInherited>()
        ?.weatherDataToStore;
  }

  @override
  bool updateShouldNotify(
    WeatherDataInherited oldWidget,
  ) {
    return oldWidget.weatherDataToStore != weatherDataToStore;
  }
}
