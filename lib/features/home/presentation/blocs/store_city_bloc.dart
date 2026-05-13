import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:clima_app/features/city/domain/use_cases/store_location_use_case.dart';
import 'package:clima_app/features/home/domain/usecases/observe_location_changes_use_case.dart';
import 'package:clima_app/features/home/presentation/blocs/store_city_event.dart';
import 'package:clima_app/features/home/presentation/blocs/store_city_state.dart';

class StoreCityBloc extends Bloc<StoreCityEvent, StoreCityState> {
  final StoreLocationUseCase _storeLocationUseCase;
  final ObserveLocationChangesUseCase _observeLocationChangesUseCase;
  StreamSubscription? _subscription;

  StoreCityBloc({
    required StoreLocationUseCase storeLocationUseCase,
    required ObserveLocationChangesUseCase observerLocationUseCase,
  })  : _storeLocationUseCase = storeLocationUseCase,
        _observeLocationChangesUseCase = observerLocationUseCase,
        super(const StoreCityState()) {
    on<PersistLocationEvent>(_storeCity);
    on<ListeningPositionEvent>(_listening);
  }

  Future<void> _listening(
    ListeningPositionEvent event,
    Emitter<StoreCityState> emit,
  ) async {
    _subscription?.cancel();

    _subscription = _observeLocationChangesUseCase().listen(
      (location) {
        print("persist");
        add(PersistLocationEvent(cityLocation: location));
      },
    );
  }

  Future<void> _storeCity(
    PersistLocationEvent event,
    Emitter<StoreCityState> emit,
  ) async {
    emit(state.copyWith(status: StoreCityStatus.loading));

    final response = await _storeLocationUseCase(event.cityLocation);

    response.fold((error) {
      emit(state.copyWith(status: StoreCityStatus.error, error: error.message));
    }, (result) {
      emit(state.copyWith(status: StoreCityStatus.success));
    });
  }

  @override
  Future<void> close() async {
    _subscription?.cancel();
    return super.close();
  }
}
