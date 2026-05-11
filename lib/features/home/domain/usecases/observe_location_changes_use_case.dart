import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:clima_app/features/home/domain/repositories/location_repository.dart';

class ObserveLocationChangesUseCase {
  final LocationRepository _repository;

  ObserveLocationChangesUseCase({
    required LocationRepository locationRepository,
  }) : _repository = locationRepository;

  Stream<CityLocation> call() {
    return _repository.watchLocation();
  }
}
