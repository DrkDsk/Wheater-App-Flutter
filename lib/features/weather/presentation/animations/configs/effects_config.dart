class EffectsConfig {
  final bool lightningEnabled;
  final double lightningFrequency;
  final double flashOpacity;
  final double boltOpacity;
  final double darkOverlayOpacity;
  final double distortionStrength;
  final Duration flashDuration;

  const EffectsConfig({
    required this.lightningEnabled,
    required this.lightningFrequency,
    this.flashOpacity = 0,
    this.boltOpacity = 0,
    this.darkOverlayOpacity = 0,
    this.distortionStrength = 0,
    this.flashDuration = const Duration(milliseconds: 120),
  });
}
