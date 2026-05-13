import 'package:geocoding/geocoding.dart';

extension PlacemarkExtension on Placemark {
  String get getDisplayName {
    return "$locality, $administrativeArea $isoCountryCode";
  }
}
