import 'package:flutter/material.dart';

class CityResultItemCard extends StatelessWidget {
  const CityResultItemCard({
    super.key,
    required this.query
  });

  final String query;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(query),
    );
  }
}