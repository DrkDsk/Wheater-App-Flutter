import 'package:clima_app/core/di/di.dart';
import 'package:clima_app/core/router/app_router.dart';
import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_cubit.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_state.dart';
import 'package:clima_app/features/favorites/presentation/widgets/favorite_city_item_card.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_bloc.dart';
import 'package:clima_app/features/home/presentation/blocs/home_page_navigation_cubit.dart';
import 'package:clima_app/features/home/presentation/blocs/home_bloc.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_home_event.dart';
import 'package:clima_app/features/home/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class SliderFavoriteWeatherCard extends StatelessWidget {
  const SliderFavoriteWeatherCard({
    super.key,
    required this.cityLocation,
    required this.index,
  });

  final int index;
  final CityLocation cityLocation;

  Future<void> deleteFavoriteWeather(BuildContext context) async {
    final currentCityId = cityLocation.timestamp;

    if (currentCityId.isEmpty) {
      return;
    }

    final favoriteCubit = context.read<FavoriteCubit>();
    favoriteCubit.delete(cityLocation: cityLocation);
  }

  ActionPane buildActionPane({required BuildContext context}) {
    final theme = Theme.of(context);

    return ActionPane(
      extentRatio: 0.35,
      motion: const ScrollMotion(),
      children: [
        CustomSlidableAction(
          backgroundColor: Colors.redAccent,
          foregroundColor: Colors.white,
          onPressed: deleteFavoriteWeather,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Icon(Icons.delete, size: 30),
              const SizedBox(height: 8),
              Text(
                "Eliminar",
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyMedium?.copyWith(fontSize: 24),
              ),
            ],
          ),
        )
      ],
    );
  }

  void onTap(BuildContext context) {
    final router = AppRouter.of(context);
    final navigationCubit = BlocProvider.of<HomePageNavigationCubit>(context);

    navigationCubit.updatePageIndex(index);

    router.goToScreenAndClear(BlocProvider(
      create: (context) => getIt<WeatherBloc>(),
      child: const HomeScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final cityName = cityLocation.name ?? "";

    return BlocListener<FavoriteCubit, FavoriteState>(
      listenWhen: (previous, current) {
        return previous.status != current.status &&
            previous.status == FavoriteStatus.loading &&
            current.status == FavoriteStatus.success;
      },
      listener: (context, state) =>
          BlocProvider.of<HomeBloc>(context).add(const LoadHomeEvent()),
      child: Slidable(
        direction: Axis.horizontal,
        enabled: cityLocation.isStored,
        endActionPane: buildActionPane(context: context),
        child: GestureDetector(
          onTap: () => onTap(context),
          child: FavoriteCityItemCard(cityName: cityName),
        ),
      ),
    );
  }
}
