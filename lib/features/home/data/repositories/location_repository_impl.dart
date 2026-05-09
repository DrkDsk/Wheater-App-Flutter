import 'package:clima_app/core/error/exceptions/unknown_exception.dart';
import 'package:clima_app/core/shared/data/datasources/location_datasource_impl.dart';
import 'package:clima_app/features/home/domain/entities/coordinate.dart';
import 'package:clima_app/features/home/domain/repositories/location_repository.dart';
import 'package:geocoding/geocoding.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSourceImpl dataSource;

  LocationRepositoryImpl(this.dataSource);

  @override
  Future<Coordinate?> getCurrentLocation() async {
    final position = await dataSource.getCurrentLocation();

    return Coordinate(
      latitude: position.latitude ?? 0,
      longitude: position.longitude ?? 0,
    );
  }

  @override
  Future<Placemark?> getLocationInformation(
      {required double latitude, required double longitude}) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      latitude,
      longitude,
    );

    return placemarks.isEmpty ? null : placemarks.first;
  }

  @override
  Future<Coordinate> ensureCoordinates({
    double? latitude,
    double? longitude,
  }) async {
    if (latitude != null && longitude != null) {
      return Coordinate(
        latitude: latitude,
        longitude: longitude,
      );
    }

    final coordinate = await getCurrentLocation();
    if (coordinate == null) {
      throw UnknownException(
        message: "No se ha podido obtener la ubicación del usuario.",
      );
    }

    return Coordinate(
      latitude: coordinate.latitude,
      longitude: coordinate.longitude,
    );
  }
}
