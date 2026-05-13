import 'package:bloc/bloc.dart';
import 'package:clima_app/features/home/domain/usecases/get_current_location_use_case.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_home_event.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_home_state.dart';

class WeatherHomeBloc extends Bloc<WeatherHomeEvent, WeatherHomeState> {
  final GetFavoritesAndCurrentLocationUseCase
      _favoritesAndCurrentLocationUseCase;

  WeatherHomeBloc(
      {required GetFavoritesAndCurrentLocationUseCase
          getFavoritesLocationUseCase})
      : _favoritesAndCurrentLocationUseCase = getFavoritesLocationUseCase,
        super(const WeatherHomeState()) {
    on<LoadHomeEvent>(_loadHome);
  }

  Future<void> _loadHome(
    LoadHomeEvent event,
    Emitter<WeatherHomeState> emit,
  ) async {
    emit(state.copyWith(status: WeatherHomeStatus.loading));

    final favoritesResult = await _favoritesAndCurrentLocationUseCase();

    final newState = favoritesResult.fold((error) {
      return state.copyWith(
        message: error.message,
        status: WeatherHomeStatus.error,
      );
    }, (result) {
      return state.copyWith(
        pages: result,
        status: WeatherHomeStatus.success,
      );
    });

    emit(newState);
  }
}
