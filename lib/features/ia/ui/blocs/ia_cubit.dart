import 'package:bloc/bloc.dart';
import 'package:clima_app/core/extensions/weather/current_weather_extension.dart';
import 'package:clima_app/features/home/domain/entities/weather_data.dart';
import 'package:clima_app/features/ia/domain/repositories/ia_repository.dart';
import 'package:clima_app/features/ia/ui/blocs/ia_state.dart';

class IACubit extends Cubit<IAState> {
  final IARepository _repository;

  IACubit({required IARepository repository})
      : _repository = repository,
        super(const IAState());

  Future<void> getSuggestion({
    required WeatherData cityWeatherData,
  }) async {
    final weather = cityWeatherData.forecast.current;
    weather.tempCelsiusText;
    weather.feelsLikeCelsiusText;
    "${weather.humidity}%";
    weather.windDirectionText;
    cityWeatherData.translatedWeather.translatedDescription;

    emit(state.copyWith(status: IAClientStatus.loading));

    /*final response = await _repository.getRecommendation(temperatureInCelsius: temperatureInCelsius, feelsLike: feelsLike, humidity: humidity, windSpeedAndGust: windSpeedAndGust, condition: condition);

    final filtered = response.where((element) => element != null)
    .map((element) => element!)
    .toList();*/

    const recommendations = [
      "usa prendas ligeras y transpirables tipo dry-fit, "
          "preferiblemente manga corta o larga delgada. Un gorro o visera te "
          "ayudará si entrenas por la mañana.",
      "lleva agua, porque la humedad puede cansarte más de lo normal. "
          "Y como hay calina, procura entrenar en un lugar que ya conozcas "
          "bien para no tener problemas de visibilidad."
    ];

    emit(
      state.copyWith(
        status: IAClientStatus.initial,
        recommendations: recommendations,
      ),
    );
  }
}
