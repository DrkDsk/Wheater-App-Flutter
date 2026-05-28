import 'package:clima_app/core/di/di.dart';
import 'package:clima_app/core/extensions/color_extension.dart';
import 'package:clima_app/core/router/app_router.dart';
import 'package:clima_app/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_bloc.dart';
import 'package:clima_app/features/home/presentation/blocs/states/weather_state.dart';
import 'package:clima_app/features/home/presentation/widgets/favorites_cities_scroll_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBottomAppBar extends StatelessWidget {
  const AppBottomAppBar({
    super.key,
    required this.currentPage,
  });

  final int currentPage;

  Future<void> navigateToFavorites(BuildContext context) async {
    final router = AppRouter.of(context);

    router.goToScreenAndClear(MultiBlocProvider(
      providers: [
        BlocProvider<WeatherBloc>(
          create: (_) => getIt<WeatherBloc>(),
        ),
      ],
      child: const FavoritesScreen(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WeatherBloc, WeatherState, Color>(
      selector: (state) => state.backgroundWeather.color,
      builder: (context, backgroundColor) {
        return Row(
          children: [
            const Spacer(),
            Expanded(
              child: SizedBox(
                height: 20,
                child: FavoritesCitiesScrollIndicator(
                  currentPage: currentPage,
                ),
              ),
            ),
            IconButton(
              color: Colors.white.customOpacity(0.8),
              icon: const Icon(CupertinoIcons.line_horizontal_3),
              onPressed: () => navigateToFavorites(context),
            ),
          ],
        );
      },
    );
  }
}
