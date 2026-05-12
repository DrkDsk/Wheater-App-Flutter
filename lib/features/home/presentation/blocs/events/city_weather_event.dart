abstract class CityWeatherEvent {
  const CityWeatherEvent();
}

class FetchWeatherEvent extends CityWeatherEvent {
  final double latitude;
  final double longitude;

  const FetchWeatherEvent({required this.latitude, required this.longitude});
}

class CitySearchEvent extends CityWeatherEvent {
  final String query;

  const CitySearchEvent({required this.query});
}

class StartListeningLocation extends CityWeatherEvent {
  const StartListeningLocation();
}
