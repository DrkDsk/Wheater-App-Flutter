import 'package:flutter/material.dart';

class WeatherContentLayer extends StatelessWidget {
  const WeatherContentLayer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Text(
              '23°',
              style: Theme.of(context).textTheme.displayLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w200,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Rainy Night',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    color: Colors.white70,
                  ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
