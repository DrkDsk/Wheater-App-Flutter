import 'package:clima_app/core/extensions/weather/current_weather_extension.dart';
import 'package:clima_app/features/home/presentation/blocs/events/city_weather_event.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_bloc.dart';
import 'package:clima_app/features/home/presentation/blocs/states/weather_state.dart';
import 'package:clima_app/features/home/presentation/blocs/states/weather_status_content_data.dart';
import 'package:clima_app/features/home/presentation/widgets/loading_view.dart';
import 'package:clima_app/features/weather/domain/resolvers/sky_background/fake_current_weather_model_builder.dart';
import 'package:clima_app/features/weather/presentation/animations/mappers/weather_animation_mapper.dart';
import 'package:clima_app/features/weather/presentation/enums/weather_scene_type.dart';
import 'package:clima_app/features/weather/presentation/layers/overlay/weather_scene_overlay_data.dart';
import 'package:clima_app/features/weather/presentation/weather_scene.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen(
      {super.key, required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late WeatherBloc _cityWeatherBloc;

  @override
  void initState() {
    super.initState();
    final latitude = widget.latitude;
    final longitude = widget.longitude;
    _cityWeatherBloc = context.read<WeatherBloc>();

    _cityWeatherBloc.add(FetchWeatherEvent(
      latitude: latitude,
      longitude: longitude,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WeatherBloc, WeatherState, WeatherStatusContentData>(
      selector: (state) {
        return WeatherStatusContentData(
          status: state.status,
          data: state.cityWeatherData,
          bgColor: state.backgroundWeather.color,
        );
      },
      builder: (context, state) {
        final data = state.data;
        final forecast = data?.forecast;

        if (state.status != WeatherStatus.success ||
            data == null ||
            forecast == null) {
          return LoadingView(color: state.bgColor);
        }

        final current = forecast.current;

        final rainAmount = current.rain?.the1H;
        final condition = data.translatedWeather.translatedDescription;
        final config = WeatherAnimationMapper.map(
          current: current,
          daily: forecast.daily.isNotEmpty ? forecast.daily.first : null,
        );

        return WeatherScene(
          config: config,
          overlayData: WeatherSceneOverlayData(
            cityName: data.cityName,
            temperature: current.tempCelsiusText,
            condition: condition.isNotEmpty ? condition : 'Rainy night',
            feelsLike: current.feelsLikeCelsiusText,
            humidity: '${current.humidity}%',
            wind: current.windDirectionText.isNotEmpty
                ? current.windDirectionText
                : current.windSpeedKmText,
            rain: rainAmount == null
                ? '--'
                : '${rainAmount.toStringAsFixed(1)} mm',
            visibility: current.visibilityTextInKm,
          ),
        );
      },
    );
  }
}
