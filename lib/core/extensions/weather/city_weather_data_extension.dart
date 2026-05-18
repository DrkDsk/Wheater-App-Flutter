import 'package:clima_app/core/enum/time_of_day_type_enum.dart';
import 'package:clima_app/core/helpers/background_weather_helper.dart';
import 'package:clima_app/core/helpers/datetime_helper.dart';
import 'package:clima_app/core/shared/domain/background_weather.dart';
import 'package:clima_app/features/home/domain/entities/weather_data.dart';

extension CityWeatherDataExtension on WeatherData {
  BackgroundWeather getBackgroundWeather() {
    final weatherType = translatedWeather.main;
    if (weatherType == null) {
      return BackgroundWeather.initial();
    }

    final currentWeather = forecast.current;

    final isNightTime = DateTimeTimeHelper.isNight(
      DateTime.now(),
      currentWeather.sunrise,
      currentWeather.sunset,
    );

    final timeType = isNightTime ? TimeOfDayType.night : TimeOfDayType.day;

    //ELIMINAR
    final lottiePath = BackgroundWeatherHelper.getWeatherLottie(
      weatherType: weatherType,
      time: timeType,
    );

    //ELIMINAR
    final backgroundColor = BackgroundWeatherHelper.getWeatherBackgroundColor(
      weatherType: weatherType,
      time: timeType,
    );

    return BackgroundWeather(lottiePath: lottiePath, color: backgroundColor);
  }
}
