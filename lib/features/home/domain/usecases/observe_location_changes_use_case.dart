import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:clima_app/features/home/domain/repositories/geo_locator_repository.dart';

class ObserveLocationChangesUseCase {
  final GeoLocatorRepository _repository;

  ObserveLocationChangesUseCase({
    required GeoLocatorRepository locationRepository,
  }) : _repository = locationRepository;

  Stream<CityLocation> call() {
    return _repository.watchLocation();
  }
}
