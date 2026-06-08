import 'package:clima_app/core/router/app_router.dart';
import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:clima_app/features/favorites/domain/entities/weather_data_to_store.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_cubit.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_state.dart';
import 'package:clima_app/features/favorites/presentation/widgets/weather_data_inherited.dart';
import 'package:clima_app/features/home/presentation/blocs/home_page_navigation_cubit.dart';
import 'package:clima_app/features/home/presentation/blocs/home_bloc.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_home_event.dart';
import 'package:clima_app/features/home/presentation/screens/home_screen.dart';
import 'package:clima_app/features/home/presentation/widgets/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowWeatherBottomSheet extends StatefulWidget {
  const ShowWeatherBottomSheet({
    super.key,
    required this.cityLocation,
  });

  final CityLocation cityLocation;

  @override
  State<ShowWeatherBottomSheet> createState() => _ShowWeatherBottomSheetState();
}

class _ShowWeatherBottomSheetState extends State<ShowWeatherBottomSheet> {
  late final FavoriteCubit _favoriteCubit;
  late final HomePageNavigationCubit _navigationCubit;
  late final HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _favoriteCubit = BlocProvider.of<FavoriteCubit>(context);
    _navigationCubit = BlocProvider.of<HomePageNavigationCubit>(context);
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _favoriteCubit.getCityIsAvailableToSave(cityLocation: widget.cityLocation);
  }

  Future<void> redirectToHome(
    BuildContext context,
    FavoriteState state,
  ) async {
    if (state.status != FavoriteStatus.success) {
      return;
    }

    final router = AppRouter.of(context);
    final newIndex = _homeBloc.state.pages.length - 1;
    _navigationCubit.updatePageIndex(newIndex);
    router.goToScreenAndClear(HomeScreen(initialIndex: newIndex));
  }

  @override
  Widget build(BuildContext context) {
    final cityLocation = widget.cityLocation;

    return BlocListener<FavoriteCubit, FavoriteState>(
      listenWhen: (previous, current) {
        return previous.status != current.status &&
            current.status == FavoriteStatus.success;
      },
      listener: (context, state) =>
          BlocProvider.of<HomeBloc>(context).add(const LoadHomeEvent()),
      child: FractionallySizedBox(
        heightFactor: 0.90,
        child: BlocConsumer<FavoriteCubit, FavoriteState>(
          listenWhen: (prev, current) => prev.status != current.status,
          listener: redirectToHome,
          builder: (context, state) {
            final isAvailableToStore = state.isAvailableToStore;

            return WeatherDataInherited(
              weatherDataToStore: WeatherDataToStore(
                cityLocation: cityLocation,
                isAvailableToStore: isAvailableToStore,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: WeatherScreen(
                      latitude: cityLocation.latitude,
                      longitude: cityLocation.longitude,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
