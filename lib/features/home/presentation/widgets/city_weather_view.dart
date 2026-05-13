import 'package:clima_app/features/home/presentation/blocs/events/city_weather_event.dart';
import 'package:clima_app/features/home/presentation/blocs/city_weather_bloc.dart';
import 'package:clima_app/features/home/presentation/widgets/weather_background_view.dart';
import 'package:clima_app/features/home/presentation/widgets/weather_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CityWeatherView extends StatefulWidget {
  const CityWeatherView({
    super.key,
    required this.latitude,
    required this.longitude,
  });

  final double latitude;
  final double longitude;

  @override
  State<CityWeatherView> createState() => _CityWeatherViewState();
}

class _CityWeatherViewState extends State<CityWeatherView> {
  late CityWeatherBloc _cityWeatherBloc;

  @override
  void initState() {
    super.initState();
    final latitude = widget.latitude;
    final longitude = widget.longitude;
    _cityWeatherBloc = context.read<CityWeatherBloc>();

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
