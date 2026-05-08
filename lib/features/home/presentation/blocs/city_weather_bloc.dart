import 'package:clima_app/core/extensions/weather/city_weather_data_extension.dart';
import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/city/domain/repositories/city_repository.dart';
import 'package:clima_app/features/home/domain/usecases/get_weather_use_case.dart';
import 'package:clima_app/features/home/presentation/blocs/events/city_weather_event.dart';
import 'package:clima_app/features/home/presentation/blocs/states/city_weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:stream_transform/stream_transform.dart';

class CityWeatherBloc extends Bloc<CityWeatherEvent, CityWeatherState> {
  final GetWeatherUseCase _getWeatherUseCase;
  final CityRepository _cityRepository;

  EventTransformer<Event> debounceRestartable<Event>(Duration duration) {
    return (events, mapper) {
      return restartable<Event>()
          .call(events.debounce(duration), mapper);
    };
  }

  CityWeatherBloc(
      {required GetWeatherUseCase getWeatherUseCase,
      required CityRepository cityRepository})
      : _getWeatherUseCase = getWeatherUseCase,
        _cityRepository = cityRepository,
        super(CityWeatherState.initial()) {
    on<FetchWeatherEvent>(_getCurrentWeather);
    on<CitySearchEvent>(
      _searchWeatherEvent,
      transformer: debounceRestartable(const Duration(milliseconds: 500)),
    );
  }

  Future<void> _getCurrentWeather(
      FetchWeatherEvent event, Emitter<CityWeatherState> emit) async {
    List<CityLocation>? previousFetchResults = state.cities;

    emit(state.copyWith(status: CityWeatherStatus.loading));

    final latitude = event.latitude;
    final longitude = event.longitude;

    final cityWeatherDataResult = await _getWeatherUseCase(
      latitude: latitude,
      longitude: longitude,
    );

    final newState = cityWeatherDataResult.fold((error) {
      return state.copyWith(
        status: CityWeatherStatus.failure,
        errorMessage: error.toString(),
      );
    }, (result) {
      final backgroundWeather = result.getBackgroundWeather();
      return state.copyWith(
        status: CityWeatherStatus.success,
        cities: previousFetchResults,
        cityWeatherData: result,
        backgroundWeather: backgroundWeather,
      );
    });

    emit(newState);
  }

  Future<void> _searchWeatherEvent(
      CitySearchEvent event, Emitter<CityWeatherState> emit) async {
    final String query = event.query;

    if (query.isEmpty) {
      emit(state.copyWith(status: CityWeatherStatus.initial, cities: []));
      return;
    }

    final cityResult = await _cityRepository.searchCity(query: query);

    final newState = cityResult.fold((left) {
      return state.copyWith(
        status: CityWeatherStatus.failure,
        errorMessage: left.message,
        cities: [],
      );
    }, (right) {
      final filteredCitySearchResult = right.data.where((element) {
        return element.state.isNotEmpty;
      }).toList();

      return state.copyWith(
        status: CityWeatherStatus.success,
        cities: filteredCitySearchResult,
      );
    });

    emit(newState);
  }
}
