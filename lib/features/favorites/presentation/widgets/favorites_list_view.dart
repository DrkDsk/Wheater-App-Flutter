import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:clima_app/features/favorites/presentation/widgets/slidable_favorite_weather_card.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_home_bloc.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_home_state.dart';
import 'package:clima_app/features/home/presentation/weather_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesListView extends StatefulWidget {
  const FavoritesListView({super.key});

  @override
  State<FavoritesListView> createState() => _FavoritesListViewState();
}

class _FavoritesListViewState extends State<FavoritesListView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 700,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherHomeBloc, WeatherHomeState>(
        builder: (context, state) {
      final pages = state.pages;
      final pagesLength = pages.length;

      return ListView.separated(
        itemCount: pagesLength,
        separatorBuilder: (context, index) {
          return const SizedBox(height: 14);
        },
        itemBuilder: (context, index) {
          final delayedAnimation = CurvedAnimation(
            parent: _controller,
            curve: Interval(
              index / pagesLength,
              1.0,
              curve: Curves.easeOut,
            ),
          );

          final page = pages[index];

          final cityLocation = switch (page) {
            CurrentLocationItem() => CityLocation(
                latitude: page.coordinate.latitude,
                longitude: page.coordinate.longitude,
                timestamp: '',
              ),
            // TODO: Handle this case.
            FavoriteWeatherItem() => CityLocation(
                latitude: page.cityLocation.latitude,
                longitude: page.cityLocation.longitude,
                timestamp: page.cityLocation.timestamp,
                name: page.cityLocation.name),
          };

          return FadeTransition(
            opacity: delayedAnimation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.2),
                end: Offset.zero,
              ).animate(delayedAnimation),
              child: SliderFavoriteWeatherCard(
                cityLocation: cityLocation,
                index: index,
              ),
            ),
          );
        },
      );
    });
  }
}
