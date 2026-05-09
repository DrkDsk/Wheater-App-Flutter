import 'package:clima_app/features/home/data/models/current_model.dart';
import 'package:clima_app/features/home/data/models/hourly_model.dart';
import 'package:clima_app/features/home/data/models/rain_model.dart';
import 'package:clima_app/features/home/data/models/weather_condition_model.dart';
import 'package:clima_app/features/home/data/models/forecast_model.dart';
import 'package:clima_app/features/home/data/repositories/search_weather_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/mocks.mocks.dart';

void main() {
  late MockSearchWeatherDataSource mockSearchWeatherDataSource;
  late SearchWeatherRepositoryImpl searchRepositoryImpl;

  setUp(() {
    mockSearchWeatherDataSource = MockSearchWeatherDataSource();
    searchRepositoryImpl =
        SearchWeatherRepositoryImpl(datasource: mockSearchWeatherDataSource);
  });

  test('debería retornar Right(model) si el datasource responde correctamente',
      () async {
    const double lat = 16.085;
    const double lon = -93.7482;

    final testModel = ForecastModel(
      latitude: lat,
      longitude: lon,
      timeZone: "America/Mexico_City",
      timezoneOffset: -21600,
      current: CurrentModel(
          dt: 1750701510,
          sunrise: 1750679083,
          sunset: 1750726183,
          temp: 305.23,
          feelsLike: 310.11,
          pressure: 1013,
          humidity: 59,
          dewPoint: 296.21,
          uvi: 13.01,
          clouds: 89,
          visibility: 10000,
          windSpeed: 3.38,
          windDeg: 257,
          windGust: 2.71,
          weather: [
            WeatherConditionModel(
                id: 500, main: "Rain", description: "light rain", icon: "10d")
          ],
          rain: RainModel(the1H: 0.13)),
      hourly: [
        HourlyModel(
          dt: 1750698000,
          temp: 305.17,
          feelsLike: 309.68,
          pressure: 1013,
          humidity: 58,
          dewPoint: 295.87,
          uvi: 11.68,
          clouds: 91,
          visibility: 10000,
          windSpeed: 2.3,
          windDeg: 261,
          windGust: 2.06,
          weather: [
            WeatherConditionModel(
                id: 804,
                main: "Clouds",
                description: "overcast clouds",
                icon: "04d")
          ],
          pop: 0,
        )
      ],
    );

    when(mockSearchWeatherDataSource.fetchSearchDataByLocation(
            lat: lat, lon: lon))
        .thenAnswer((_) async => testModel);

    final result =
        await searchRepositoryImpl.getWeatherByLocation(lat: lat, lon: lon);

    expect(result, Right(testModel));
    verify(mockSearchWeatherDataSource.fetchSearchDataByLocation(
            lat: lat, lon: lon))
        .called(1);
  });
}
