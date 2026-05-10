import 'package:clima_app/core/shared/domain/background_weather.dart';
import 'package:clima_app/core/shared/ui/widgets/lottie_viewer.dart';
import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_cubit.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_fetch_state.dart';
import 'package:clima_app/features/home/presentation/blocs/home_page_navigation_cubit.dart';
import 'package:clima_app/features/home/presentation/widgets/city_weather_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesPageBuilder extends StatefulWidget {
  const FavoritesPageBuilder({super.key, required this.pageController});

  final PageController pageController;

  @override
  State<FavoritesPageBuilder> createState() => _FavoritesPageBuilderState();
}

class _FavoritesPageBuilderState extends State<FavoritesPageBuilder> {
  late final HomePageNavigationCubit homePageNavigationCubit;
  late final BackgroundWeather _emptyBackgroundWeather;

  @override
  @override
  void initState() {
    super.initState();
    homePageNavigationCubit = BlocProvider.of<HomePageNavigationCubit>(context);
    _emptyBackgroundWeather = BackgroundWeather.initial();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<FavoriteCubit, FavoriteState, List<CityLocation>>(
      selector: (state) => state.cities,
      builder: (context, cities) {
        if (cities.isEmpty) {
          return LottieViewer(
            path: _emptyBackgroundWeather.lottiePath,
            backgroundColor: _emptyBackgroundWeather.color,
          );
        }

        return PageView.builder(
          controller: widget.pageController,
          itemCount: cities.length,
          onPageChanged: homePageNavigationCubit.updatePageIndex,
          itemBuilder: (context, index) {
            final city = cities[index];

            return CityWeatherView(
              cityName: city.cityName,
              latitude: city.latitude,
              longitude: city.longitude,
            );
          },
        );
      },
    );
  }
}
