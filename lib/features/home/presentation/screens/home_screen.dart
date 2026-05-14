import 'package:clima_app/core/shared/ui/cubits/network_cubit.dart';
import 'package:clima_app/core/shared/ui/cubits/network_state.dart';
import 'package:clima_app/core/shared/ui/widgets/network_status_builder.dart';
import 'package:clima_app/features/home/presentation/blocs/home_page_navigation_cubit.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_home_bloc.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_home_event.dart';
import 'package:clima_app/features/home/presentation/blocs/weather_home_state.dart';
import 'package:clima_app/features/home/presentation/widgets/favorites_page_builder.dart';
import 'package:clima_app/features/home/presentation/widgets/custom_bottom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.initialIndex});

  final int? initialIndex;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _pageController;
  late final HomePageNavigationCubit _navigationCubit;
  late final WeatherHomeBloc _weatherHomeBloc;

  @override
  void initState() {
    super.initState();
    _navigationCubit = BlocProvider.of<HomePageNavigationCubit>(context);
    _weatherHomeBloc = BlocProvider.of<WeatherHomeBloc>(context);
    _pageController = PageController(
      initialPage: widget.initialIndex ?? _navigationCubit.state,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void retryFavorites(BuildContext context, NetworkState state) {
    final isConnected = state.status == NetworkStatus.connected;
    final emptyCities = _weatherHomeBloc.state.pages.isEmpty;

    if (isConnected && emptyCities) {
      _weatherHomeBloc.add(const LoadHomeEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WeatherHomeBloc, WeatherHomeState>(
      listenWhen: (previous, current) {
        return previous.status != current.status &&
            current.status == WeatherHomeStatus.success;
      },
      listener: (context, state) {
        final lastIndex = state.pages.length - 1;

        if (_pageController.hasClients) {
          _pageController.animateToPage(
            lastIndex,
            duration: const Duration(milliseconds: 300),
            curve: Curves.ease,
          );
        }
      },
      child: BlocSelector<HomePageNavigationCubit, int, int>(
        selector: (state) => state,
        builder: (context, currentPage) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            bottomNavigationBar: CustomBottomAppBar(
              currentPage: currentPage,
            ),
            body: SafeArea(
              child: BlocConsumer<NetworkCubit, NetworkState>(
                listenWhen: (prev, current) => prev.status != current.status,
                buildWhen: (prev, current) => prev.status != current.status,
                listener: retryFavorites,
                builder: (context, state) {
                  return Column(
                    children: [
                      NetworkStatusBuilder(
                        isConnected: state.status == NetworkStatus.connected,
                      ),
                      Expanded(
                        child: FavoritesPageBuilder(
                          pageController: _pageController,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
