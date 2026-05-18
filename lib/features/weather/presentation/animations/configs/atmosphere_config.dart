class AtmosphereConfig {
  final double cloudDensity;
  final double fogIntensity;

  final bool starsVisible;
  final bool moonVisible;

  const AtmosphereConfig({
    required this.cloudDensity,
    required this.fogIntensity,
    required this.starsVisible,
    required this.moonVisible,
  });
}
