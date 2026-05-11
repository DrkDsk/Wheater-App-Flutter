import 'package:clima_app/core/extensions/weather/current_weather_extension.dart';
import 'package:clima_app/features/home/presentation/blocs/city_weather_bloc.dart';
import 'package:clima_app/features/home/presentation/blocs/states/city_weather_state.dart';
import 'package:clima_app/features/home/presentation/blocs/states/weather_status_content_data.dart';
import 'package:clima_app/features/home/presentation/widgets/daily_list_weather.dart';
import 'package:clima_app/features/home/presentation/widgets/detail_weather_grid.dart';
import 'package:clima_app/features/home/presentation/widgets/header_weather.dart';
import 'package:clima_app/features/home/presentation/widgets/hourly_list_weather.dart';
import 'package:clima_app/features/home/presentation/widgets/loading_view.dart';
import 'package:clima_app/features/home/presentation/widgets/summary_description.dart';
import 'package:clima_app/features/ia/ui/blocs/widgets/ia_content_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherContent extends StatelessWidget {
  const WeatherContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CityWeatherBloc, CityWeatherState,
        WeatherStatusContentData>(
      selector: (state) {
        return WeatherStatusContentData(
          status: state.status,
          data: state.cityWeatherData,
          bgColor: state.backgroundWeather.color,
        );
      },
      builder: (context, state) {
        final bgColor = state.bgColor;
        final data = state.data;

        final status = state.status;

        if (status != CityWeatherStatus.success || data == null) {
          return LoadingView(color: bgColor);
        }

        final forecast = data.forecast;
        final current = forecast.current;
        final daily = forecast.daily;
        final hourly = forecast.hourly;
        final summary = daily.isNotEmpty ? daily.first.summary : null;
        final cityName = data.cityName;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              HeaderWeather(
                cityName: cityName,
                translatedWeather: data.translatedWeather,
                temp: current.tempCelsiusText,
              ),
              const SizedBox(height: 10),
              IAContentView(cityWeatherData: data),
              const SizedBox(height: 10),
              if (summary != null) ...[
                SummaryDescription(
                  backgroundColor: bgColor,
                  summaryDescription: summary,
                ),
                const SizedBox(height: 10),
              ],
              if (hourly.isNotEmpty) ...[
                HourlyListWeather(
                  hourly: hourly,
                  backgroundColor: bgColor,
                ),
              ],
              const SizedBox(height: 10),
              if (daily.isNotEmpty) ...[
                DailyListWeather(
                  daily: daily,
                  backgroundColor: bgColor,
                ),
              ],
              const SizedBox(height: 10),
              DetailWeatherGrid(
                weather: current,
                backgroundColor: bgColor,
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}
