import 'dart:async';

import 'package:clima_app/core/error/exceptions/network_exception.dart';
import 'package:clima_app/core/error/exceptions/unknown_exception.dart';
import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/core/extensions/location/location_data_extension.dart';
import 'package:clima_app/core/shared/data/datasources/location_datasource_impl.dart';
import 'package:clima_app/features/city/domain/entities/city_location_entity.dart';
import 'package:clima_app/features/favorites/data/datasources/favorite_weather_datasource.dart';
import 'package:clima_app/features/favorites/data/models/city_location_hive_model.dart';
import 'package:clima_app/features/favorites/data/services/favorite_service.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_repository.dart';
import 'package:dartz/dartz.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteWeatherDataSource _favoriteWeatherDataSource;
  final LocationDataSourceImpl _locationDataSourceImpl;

  const FavoriteRepositoryImpl({
    required FavoriteWeatherDataSource favoriteWeatherDataSource,
    required LocationMapper favoriteService,
    required LocationDataSourceImpl locationDataSource,
  })  : _favoriteWeatherDataSource = favoriteWeatherDataSource,
        _locationDataSourceImpl = locationDataSource;

  @override
  Future<Either<Failure, bool>> store(
      {required CityLocation cityLocation}) async {
    try {
      final cityLocationKey = cityLocation.cityName;

      final locationModel = await _favoriteWeatherDataSource.findByKey(
        key: cityLocationKey,
      );

      final locationCache =
          await _favoriteWeatherDataSource.getStoredLocationCache();

      if (locationModel != null) {
        return const Right(false);
      }

      final cityModel = CityLocationHiveModel.fromEntity(cityLocation);
      await _favoriteWeatherDataSource.store(city: cityModel);

      if (locationCache != null && cityModel.key == locationCache.key) {
        return const Right(false);
      }

      return const Right(true);
    } on UnknownException catch (e) {
      return Left(UnexpectedFailure(e.message));
    } on NetworkException catch (e) {
      return Left(UnexpectedFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<CityLocation>>> index() async {
    try {
      final (favoritesCitiesModels, cachedLocationModel) = await (
        _favoriteWeatherDataSource.getAll(),
        _favoriteWeatherDataSource.getStoredLocationCache(),
      ).wait;

      final cachedLocation = cachedLocationModel?.toEntity();

      final locationData = cachedLocation ??
          (await _locationDataSourceImpl.getCurrentLocation()).toCityLocation();

      final cityLocationKey = locationData.cityName;
      final storedCities =
          favoritesCitiesModels.map((city) => city.toEntity()).toList();

      storedCities
        ..removeWhere((element) => element.cityName == cityLocationKey)
        ..insert(0, locationData);

      /*unawaited(
        _favoriteWeatherDataSource.storeLocationCache(location: locationData),
      );*/

      return Right(storedCities);
    } on UnknownException catch (e) {
      return Left(UnexpectedFailure(e.message));
    } on NetworkException catch (e) {
      return Left(UnexpectedFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> delete(
      {required CityLocation cityLocation}) async {
    try {
      final cityLocationModel =
          await _favoriteWeatherDataSource.findById(id: cityLocation.id);

      if (cityLocationModel == null) {
        return const Right(false);
      }

      await _favoriteWeatherDataSource.delete(model: cityLocationModel);

      return const Right(true);
    } on UnknownException catch (e) {
      return Left(UnexpectedFailure(e.message));
    } on NetworkException catch (e) {
      return Left(UnexpectedFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> isAvailableToStore(
      {required CityLocation cityLocation}) async {
    try {
      final cityLocationKey = cityLocation.cityName;

      final (cacheLocationCity, storedCity) = await (
        _favoriteWeatherDataSource.getStoredLocationCache(),
        _favoriteWeatherDataSource.findByKey(key: cityLocationKey),
      ).wait;

      final exists = cacheLocationCity?.cityName == cityLocationKey ||
          storedCity?.cityName == cityLocationKey;

      return Right(!exists);
    } on UnknownException catch (e) {
      return Left(UnexpectedFailure(e.message));
    } on NetworkException catch (e) {
      return Left(UnexpectedFailure(e.message));
    }
  }
}
