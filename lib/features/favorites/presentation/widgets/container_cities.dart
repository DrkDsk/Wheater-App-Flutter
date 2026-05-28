import 'package:clima_app/features/city/presentation/widgets/city_search_result.dart';
import 'package:clima_app/features/favorites/presentation/widgets/favorites_list_view.dart';
import 'package:clima_app/features/home/presentation/blocs/states/weather_state.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContainerCities extends StatelessWidget {
  const ContainerCities({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        switch (state.status) {
          case WeatherStatus.failure:
            return Text(state.message, style: theme.textTheme.bodyMedium);
          case WeatherStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case WeatherStatus.success:
            return CitySearchResult(cities: state.cities);
          case WeatherStatus.initial:
            return const FavoritesListView();
        }
      },
    );
  }
}
