import 'package:clima_app/features/home/presentation/weather_list_item.dart';

enum WeatherHomeStatus { idle, loading, success, error }

final class WeatherHomeState {
  final WeatherHomeStatus status;
  final List<WeatherListItem> pages;
  final String? message;

  const WeatherHomeState({
    this.status = WeatherHomeStatus.idle,
    this.pages = const [],
    this.message,
  });

  WeatherHomeState copyWith({
    WeatherHomeStatus? status,
    List<WeatherListItem>? pages,
    String? message,
  }) {
    return WeatherHomeState(
      status: status ?? this.status,
      pages: pages ?? this.pages,
      message: message ?? this.message,
    );
  }
}
