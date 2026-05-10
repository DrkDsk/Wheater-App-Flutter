import 'dart:async';

import 'package:clima_app/core/error/exceptions/network_exception.dart';
import 'package:clima_app/core/error/exceptions/unknown_exception.dart';
import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/core/shared/data/datasources/location_datasource.dart';
import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:clima_app/features/favorites/data/datasources/favorite_datasource.dart';
import 'package:clima_app/features/favorites/data/models/city_location_hive_model.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_repository.dart';
import 'package:dartz/dartz.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteDataSource _favoriteWeatherDataSource;
  final LocationLocalDatasource _locationLocalDatasource;

  const FavoriteRepositoryImpl({
    required FavoriteDataSource favoriteWeatherDataSource,
    required LocationLocalDatasource locationLocalDataSource,
  })  : _favoriteWeatherDataSource = favoriteWeatherDataSource,
        _locationLocalDatasource = locationLocalDataSource;

  @override
  Future<Either<Failure, bool>> store({
    required CityLocation cityLocation,
  }) async {
    try {
      final cityLocationKey = cityLocation.timestamp;

      final locationModel = await _favoriteWeatherDataSource.findByKey(
        key: cityLocationKey,
      );

      final locationCache = await _locationLocalDatasource.getCachedLocation();

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
      final citiesModels = await _favoriteWeatherDataSource.index();

      final storedCities = citiesModels.map((city) => city.toEntity()).toList();

      return Right(storedCities);
    } on UnknownException catch (e) {
      return Left(UnexpectedFailure(e.message));
    } on NetworkException catch (e) {
      return Left(UnexpectedFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, bool>> delete({
    required CityLocation cityLocation,
  }) async {
    try {
      final cityLocationModel = await _favoriteWeatherDataSource.findById(
        id: cityLocation.timestamp,
      );

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
  Future<Either<Failure, bool>> isAvailableToStore({
    required CityLocation cityLocation,
  }) async {
    try {
      final cityLocationKey = cityLocation.timestamp;

      final (cacheLocationCity, storedCity) = await (
        _locationLocalDatasource.getCachedLocation(),
        _favoriteWeatherDataSource.findByKey(key: cityLocationKey),
      ).wait;

      final exists = cacheLocationCity?.timestamp == cityLocationKey ||
          storedCity?.timestamp == cityLocationKey;

      return Right(!exists);
    } on UnknownException catch (e) {
      return Left(UnexpectedFailure(e.message));
    } on NetworkException catch (e) {
      return Left(UnexpectedFailure(e.message));
    }
  }
}
