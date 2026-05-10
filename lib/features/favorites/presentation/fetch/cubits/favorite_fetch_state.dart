import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:equatable/equatable.dart';

enum FavoriteStatus { initial, loading, success, failure }

class FavoriteState with EquatableMixin {
  final FavoriteStatus status;
  final List<CityLocation> cities;
  final String message;
  final bool isAvailableToStore;

  const FavoriteState({
    this.status = FavoriteStatus.initial,
    this.cities = const [],
    this.isAvailableToStore = false,
    this.message = "",
  });

  FavoriteState copyWith({
    FavoriteStatus? status,
    List<CityLocation>? cities,
    String? message,
    bool? isAvailableToStore,
  }) {
    return FavoriteState(
      status: status ?? this.status,
      cities: cities ?? this.cities,
      message: message ?? this.message,
      isAvailableToStore: isAvailableToStore ?? this.isAvailableToStore,
    );
  }

  @override
  List<Object?> get props => [
        status,
        cities,
        message,
        isAvailableToStore,
      ];
}
