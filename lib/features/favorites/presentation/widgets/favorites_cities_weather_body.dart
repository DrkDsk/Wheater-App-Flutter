import 'package:clima_app/features/favorites/presentation/widgets/city_search_results_list.dart';
import 'package:clima_app/features/favorites/presentation/widgets/favorites_list_view.dart';
import 'package:clima_app/features/home/presentation/blocs/states/city_weather_state.dart';
import 'package:clima_app/features/home/presentation/blocs/city_weather_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCitiesWeatherBody extends StatelessWidget {
  const FavoritesCitiesWeatherBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocBuilder<WeatherBloc, CityWeatherState>(
      builder: (context, state) {
        switch (state.status) {
          case CityWeatherStatus.failure:
            return Text(state.message, style: theme.textTheme.bodyMedium);
          case CityWeatherStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case CityWeatherStatus.success:
            return CitySearchResultsList(cities: state.cities);
          case CityWeatherStatus.initial:
            return const FavoritesListView();
        }
      },
    );
  }
}
