import 'package:clima_app/core/constants/weather_constants.dart';
import 'package:clima_app/core/di/di.dart';
import 'package:clima_app/core/shared/ui/cubits/network_cubit.dart';
import 'package:clima_app/core/theme/light_theme.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_cubit.dart';
import 'package:clima_app/features/home/presentation/blocs/city_weather_bloc.dart';
import 'package:clima_app/features/home/presentation/blocs/home_page_navigation_cubit.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_home_bloc.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_home_event.dart';
import 'package:clima_app/features/home/presentation/screens/home_screen.dart';
import 'package:clima_app/features/ia/ui/blocs/ia_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _precacheAnimations();
  }

  Future<void> _precacheAnimations() async {
    final animationsPath = WeatherLottieConstants.precacheAnimations;

    for (final path in animationsPath) {
      await AssetLottie(path).load();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<NetworkCubit>()),
        BlocProvider(
          create: (_) => getIt<FavoriteCubit>(),
        ),
        BlocProvider(
          create: (_) => getIt<WeatherHomeBloc>()..add(const LoadHomeEvent()),
        ),
        BlocProvider(
          create: (_) => getIt<CityWeatherBloc>(),
        ),
        BlocProvider(create: (_) => getIt<IACubit>()),
        BlocProvider(create: (_) => getIt<HomePageNavigationCubit>())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        title: 'App del clima',
        home: const HomeScreen(),
      ),
    );
  }
}
