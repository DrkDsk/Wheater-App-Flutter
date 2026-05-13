import 'package:equatable/equatable.dart';

enum FavoriteStatus { initial, loading, success, failure }

class FavoriteState with EquatableMixin {
  final FavoriteStatus status;
  final String message;
  final bool isAvailableToStore;

  const FavoriteState({
    this.status = FavoriteStatus.initial,
    this.isAvailableToStore = false,
    this.message = "",
  });

  FavoriteState copyWith({
    FavoriteStatus? status,
    String? message,
    bool? isAvailableToStore,
  }) {
    return FavoriteState(
      status: status ?? this.status,
      message: message ?? this.message,
      isAvailableToStore: isAvailableToStore ?? this.isAvailableToStore,
    );
  }

  @override
  List<Object?> get props => [
        status,
        message,
        isAvailableToStore,
      ];
}
