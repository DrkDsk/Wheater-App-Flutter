import 'package:clima_app/core/shared/ui/widgets/lottie_loading.dart';
import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_cubit.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_fetch_state.dart';
import 'package:clima_app/features/home/presentation/blocs/city_weather_bloc.dart';
import 'package:clima_app/features/home/presentation/blocs/home_page_navigation_cubit.dart';
import 'package:clima_app/features/home/presentation/blocs/states/city_weather_state.dart';
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
  @override
  void initState() {
    super.initState();
    homePageNavigationCubit = BlocProvider.of<HomePageNavigationCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CityWeatherBloc, CityWeatherState>(
      listenWhen: (previous, current) =>
          (previous != current) && current.status == CityWeatherStatus.success,
      listener: (context, state) {},
      child: BlocSelector<FavoriteCubit, FavoriteState, List<CityLocation>>(
        selector: (state) => state.cities,
        builder: (context, cities) {
          if (cities.isEmpty) {
            return const LottieLoading();
          }

          return PageView.builder(
            controller: widget.pageController,
            itemCount: cities.length,
            onPageChanged: homePageNavigationCubit.updatePageIndex,
            itemBuilder: (context, index) {
              final city = cities[index];

              return CityWeatherView(
                latitude: city.latitude,
                longitude: city.longitude,
              );
            },
          );
        },
      ),
    );
  }
}
