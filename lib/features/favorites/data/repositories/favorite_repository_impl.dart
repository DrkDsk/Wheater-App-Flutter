import 'dart:async';

import 'package:clima_app/core/error/exceptions/network_exception.dart';
import 'package:clima_app/core/error/exceptions/unknown_exception.dart';
import 'package:clima_app/core/error/failures/failure.dart';
import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:clima_app/features/favorites/data/datasources/favorite_datasource.dart';
import 'package:clima_app/features/favorites/data/models/city_location_hive_model.dart';
import 'package:clima_app/features/favorites/domain/repository/favorite_repository.dart';
import 'package:dartz/dartz.dart';
import 'dart:math';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteDataSource _favoriteWeatherDataSource;

  const FavoriteRepositoryImpl({
    required FavoriteDataSource favoriteWeatherDataSource,
  }) : _favoriteWeatherDataSource = favoriteWeatherDataSource;

  @override
  Future<Either<Failure, bool>> store({
    required CityLocation cityLocation,
  }) async {
    try {
      final cityLocationKey = cityLocation.timestamp;

      final locationModel = await _favoriteWeatherDataSource.findByKey(
        key: cityLocationKey,
      );

      if (locationModel != null) {
        return const Right(false);
      }

      final cityModel = CityLocationHiveModel.fromEntity(cityLocation);
      await _favoriteWeatherDataSource.store(city: cityModel);

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
  Future<bool> isAvailableToStore(
      {required CityLocation cityLocation,
      required CityLocation currentLocation}) async {
    try {
      final cityLocationKey = cityLocation.timestamp;

      final storedCity =
          await _favoriteWeatherDataSource.findByKey(key: cityLocationKey);

      final same = isSameLocation(
          lat1: cityLocation.latitude,
          lon1: cityLocation.longitude,
          lat2: currentLocation.latitude,
          lon2: currentLocation.longitude);

      return !same;
    } on UnknownException catch (e) {
      throw UnknownException(message: e.message);
    } on NetworkException catch (e) {
      throw UnknownException(message: e.message);
    }
  }

  bool isSameLocation({
    required double lat1,
    required double lon1,
    required double lat2,
    required double lon2,
    double precisionKm = 1.0,
  }) {
    const earthRadiusKm = 6371;

    double degToRad(double deg) => deg * pi / 180;

    final dLat = degToRad(lat2 - lat1);
    final dLon = degToRad(lon2 - lon1);

    final a = pow(sin(dLat / 2), 2) +
        cos(degToRad(lat1)) * cos(degToRad(lat2)) * pow(sin(dLon / 2), 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));

    final distance = earthRadiusKm * c;

    return distance <= precisionKm;
  }
}
