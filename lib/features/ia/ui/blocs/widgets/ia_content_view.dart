import 'dart:ui';

import 'package:clima_app/core/extensions/color_extension.dart';
import 'package:clima_app/core/extensions/string_extension.dart';
import 'package:clima_app/features/home/domain/entities/weather_data.dart';
import 'package:clima_app/features/ia/ui/blocs/ia_cubit.dart';
import 'package:clima_app/features/ia/ui/blocs/ia_state.dart';
import 'package:clima_app/features/ia/ui/blocs/widgets/ia_suggestion_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IAContentView extends StatefulWidget {
  const IAContentView({
    super.key,
    required this.cityWeatherData,
  });

  final WeatherData cityWeatherData;

  @override
  State<IAContentView> createState() => _IAContentViewState();
}

class _IAContentViewState extends State<IAContentView> {
  late final IACubit _iaCubit;

  @override
  void initState() {
    super.initState();
    _iaCubit = BlocProvider.of<IACubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: BlocBuilder<IACubit, IAState>(
          builder: (context, state) {
            if (state.recommendations.isEmpty) {
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _iaCubit.getSuggestion(
                  cityWeatherData: widget.cityWeatherData,
                ),
                child: const IASuggestionButton(),
              );
            }

            return Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade100.customOpacity(0.1),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(8),
                  top: Radius.circular(8),
                ),
                border: Border.all(
                  color: Colors.white.customOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  const IASuggestionButton(),
                  IADescriptionCard(
                    recommendations: state.recommendations,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class IADescriptionCard extends StatelessWidget {
  final List<String> recommendations;

  const IADescriptionCard({super.key, required this.recommendations});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
      child: ListView.separated(
        itemCount: recommendations.length,
        separatorBuilder: (context, index) => const SizedBox(height: 15),
        itemBuilder: (context, index) {
          final text = recommendations[index];

          return Text(
            text.firstUppercase(),
            style: const TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),
          );
        },
      ),
    );
  }
}
