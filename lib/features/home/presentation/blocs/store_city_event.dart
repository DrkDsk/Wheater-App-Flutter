import 'package:clima_app/features/city/domain/entities/city_location.dart';

sealed class StoreCityEvent {
  const StoreCityEvent();
}

final class ListeningPositionEvent extends StoreCityEvent {
  const ListeningPositionEvent();
}

final class PersistLocationEvent extends StoreCityEvent {
  final CityLocation cityLocation;

  const PersistLocationEvent({required this.cityLocation});
}
