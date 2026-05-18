import 'package:clima_app/features/home/presentation/blocs/events/city_weather_event.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_bloc.dart';
import 'package:clima_app/features/home/presentation/widgets/weather_background_view.dart';
import 'package:clima_app/features/home/presentation/widgets/weather_content.dart';
import 'package:clima_app/features/weather/presentation/animations/mappers/weather_animation_mapper.dart';
import 'package:clima_app/features/weather/presentation/layers/background/weather_content_layer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({
    super.key,
    required this.latitude,
    required this.longitude,
  });

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
    return const Stack(
      children: [
        WeatherBackgroundView(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: WeatherContent(),
        ),
      ],
    );
  }
}
