import 'dart:async';

import 'package:clima_app/core/extensions/color_extension.dart';
import 'package:clima_app/features/home/presentation/blocs/events/city_weather_event.dart';
import 'package:clima_app/features/home/presentation/blocs/city_weather_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCityFormField extends StatefulWidget {
  const SearchCityFormField({
    super.key,
  });

  @override
  State<SearchCityFormField> createState() => _SearchCityFormFieldState();
}

class _SearchCityFormFieldState extends State<SearchCityFormField> {
  Timer? _debounce;
  late CityWeatherBloc _cityWeatherBloc;

  @override
  void initState() {
    _cityWeatherBloc = context.read<CityWeatherBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CupertinoTextField(
      onChanged: (value) => _cityWeatherBloc.add(CitySearchEvent(query: value)),
      style: TextStyle(
        color: theme.colorScheme.onPrimary,
        fontSize: 24,
      ),
      prefix: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Icon(
          CupertinoIcons.search,
          color: CupertinoColors.systemGrey.customOpacity(0.5),
        ),
      ),
      suffix: Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Icon(
          CupertinoIcons.mic,
          color: CupertinoColors.systemGrey.customOpacity(0.5),
        ),
      ),
      decoration: BoxDecoration(
        color: CupertinoColors.systemGrey.customOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      placeholder: 'Buscar ciudad',
      placeholderStyle: TextStyle(color: theme.colorScheme.onPrimary),
    );
  }
}
