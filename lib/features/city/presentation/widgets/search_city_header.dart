import 'package:clima_app/features/city/presentation/widgets/search_city_form_field.dart';
import 'package:flutter/material.dart';

class SearchCityHeader extends StatelessWidget {
  const SearchCityHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Clima", style: theme.textTheme.titleLarge),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: SearchCityFormField(),
        ),
      ],
    );
  }
}
