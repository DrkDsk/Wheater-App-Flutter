enum StoreCityStatus { idle, loading, success, error }

final class StoreCityState {
  final StoreCityStatus status;
  final String? error;

  const StoreCityState({this.status = StoreCityStatus.idle, this.error});

  StoreCityState copyWith({
    StoreCityStatus? status,
    String? error,
  }) {
    return StoreCityState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }
}
