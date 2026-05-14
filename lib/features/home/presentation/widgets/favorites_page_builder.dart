import 'package:clima_app/core/shared/ui/widgets/lottie_loading.dart';
import 'package:clima_app/features/home/presentation/blocs/home_page_navigation_cubit.dart';
import 'package:clima_app/features/home/presentation/blocs/home_bloc.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_home_state.dart';
import 'package:clima_app/features/home/presentation/weather_list_item.dart';
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

  @override
  void initState() {
    super.initState();
    homePageNavigationCubit = BlocProvider.of<HomePageNavigationCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HomeBloc, WeatherHomeState, List<WeatherListItem>>(
      selector: (state) => state.pages,
      builder: (context, pages) {
        if (pages.isEmpty) {
          return const LottieLoading();
        }

        return PageView.builder(
          controller: widget.pageController,
          itemCount: pages.length,
          onPageChanged: homePageNavigationCubit.updatePageIndex,
          itemBuilder: (context, index) {
            final page = pages[index];

            return switch (page) {
              CurrentLocationItem() => CityWeatherView(
                  latitude: page.coordinate.latitude,
                  longitude: page.coordinate.longitude,
                ),
              FavoriteWeatherItem() => CityWeatherView(
                  latitude: page.cityLocation.latitude,
                  longitude: page.cityLocation.longitude,
                ),
            };
          },
        );
      },
    );
  }
}
