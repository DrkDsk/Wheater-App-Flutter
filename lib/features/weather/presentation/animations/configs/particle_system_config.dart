import 'package:clima_app/features/weather/presentation/enums/particle_type.dart';

class ParticleSystemConfig {
  final ParticleType particleType;

  final double density;
  final double speed;

  const ParticleSystemConfig({
    required this.particleType,
    required this.density,
    required this.speed,
  });
}
