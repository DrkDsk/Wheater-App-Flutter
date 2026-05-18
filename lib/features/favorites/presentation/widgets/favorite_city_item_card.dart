import 'package:clima_app/core/extensions/color_extension.dart';
import 'package:flutter/material.dart';

class FavoriteCityItemCard extends StatelessWidget {
  const FavoriteCityItemCard({super.key, required this.cityName});

  final String cityName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: MediaQuery.of(context).size.height * 0.11,
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.grey.customOpacity(0.045),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
        child: Text(
          cityName,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
