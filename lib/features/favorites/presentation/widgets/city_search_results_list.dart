import 'package:clima_app/features/city/domain/entities/city_location.dart';
import 'package:clima_app/features/favorites/presentation/widgets/city_result_item_card.dart';
import 'package:clima_app/features/favorites/presentation/widgets/show_weather_bottom_sheet.dart';
import 'package:flutter/material.dart';

class CitySearchResultsList extends StatelessWidget {
  const CitySearchResultsList({
    super.key,
    required this.cities,
  });

  final List<CityLocation> cities;

  Future<void> getWeatherSelected(
      {required CityLocation cityLocation,
      required BuildContext context}) async {
    _showWeatherBottomSheet(context, cityLocation: cityLocation);
  }

  void _showWeatherBottomSheet(
    BuildContext context, {
    required CityLocation cityLocation,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      builder: (context) => ShowWeatherBottomSheet(
        cityLocation: cityLocation,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) => const SizedBox(height: 4),
      itemCount: cities.length,
      separatorBuilder: (context, index) {
        final cityLocation = cities[index];
        final cityName = cityLocation.name ?? "";

        return GestureDetector(
          onTap: () => getWeatherSelected(
            cityLocation: cityLocation,
            context: context,
          ),
          child: CityResultItemCard(query: cityName),
        );
      },
    );
  }
}
