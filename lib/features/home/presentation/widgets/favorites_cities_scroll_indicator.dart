import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_cubit.dart';
import 'package:clima_app/features/favorites/presentation/fetch/cubits/favorite_fetch_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesCitiesScrollIndicator extends StatelessWidget {
  const FavoritesCitiesScrollIndicator({super.key, required this.currentPage});

  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoriteCubit, FavoriteState>(
      builder: (context, state) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: state.cities.length,
          itemBuilder: (context, index) {
            final isActive = currentPage == index;
            return AnimatedContainer(
                width: 10,
                height: 10,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                duration: const Duration(milliseconds: 100),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive ? Colors.white : Colors.grey,
                ));
          },
        );
      },
    );
  }
}
