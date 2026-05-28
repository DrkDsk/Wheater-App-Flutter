class SkyAtmosphereMetrics {
  final double brightness;
  final double warmth;
  final double haze;
  final double storminess;
  final double solarElevation;
  final double uvFactor;
  final double cloudFactor;
  final double windFactor;
  final double rainFactor;

  const SkyAtmosphereMetrics({
    required this.brightness,
    required this.warmth,
    required this.haze,
    required this.storminess,
    required this.solarElevation,
    required this.uvFactor,
    required this.cloudFactor,
    required this.windFactor,
    required this.rainFactor,
  });
}
