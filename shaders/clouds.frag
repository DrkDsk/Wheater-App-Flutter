#include <flutter/runtime_effect.glsl>

precision highp float;

out vec4 fragColor;

// Uniform order from CloudShaderPainter:
// 0: uResolution.x
// 1: uResolution.y
// 2: uTime
// 3: uCloudCoverage
// 4: uCloudDensity
// 5: uCloudOpacity
// 6: uCloudSpeed
// 7: uCloudScale
// 8: uCloudSoftness

uniform vec2 uResolution;
uniform float uTime;
uniform float uCloudCoverage;
uniform float uCloudDensity;
uniform float uCloudOpacity;
uniform float uCloudSpeed;
uniform float uCloudScale;
uniform float uCloudSoftness;

float hash(vec2 p) {
  p = fract(p * vec2(123.34, 456.21));
  p += dot(p, p + 45.32);
  return fract(p.x * p.y);
}

float noise(vec2 p) {
  vec2 i = floor(p);
  vec2 f = fract(p);
  vec2 u = f * f * (3.0 - 2.0 * f);

  float a = hash(i);
  float b = hash(i + vec2(1.0, 0.0));
  float c = hash(i + vec2(0.0, 1.0));
  float d = hash(i + vec2(1.0, 1.0));

  return mix(mix(a, b, u.x), mix(c, d, u.x), u.y);
}

float fbm(vec2 p) {
  float value = 0.0;
  float amplitude = 0.5;
  mat2 rotation = mat2(0.80, -0.60, 0.60, 0.80);

  for (int i = 0; i < 6; i++) {
    value += amplitude * noise(p);
    p = rotation * p * 2.03 + vec2(17.7, 9.2);
    amplitude *= 0.52;
  }

  return value;
}

void main() {
  vec2 fragCoord = FlutterFragCoord().xy;
  vec2 uv = fragCoord / max(uResolution, vec2(1.0));
  float aspect = uResolution.x / max(uResolution.y, 1.0);

  vec2 p = vec2((uv.x - 0.5) * aspect, uv.y - 0.5);
  float scale = mix(1.35, 0.38, clamp(uCloudScale, 0.0, 1.0));
  float time = uTime * mix(0.012, 0.075, clamp(uCloudSpeed, 0.0, 1.0));
  vec2 drift = vec2(time, time * 0.18);

  float base = fbm(p / scale + drift);
  float broadMass = fbm(p / (scale * 1.9) + drift * 0.42 + vec2(4.0, 1.7));
  float cloudField = smoothstep(0.18, 0.92, mix(base, broadMass, 0.46));

  float coverage = clamp(uCloudCoverage, 0.0, 1.0);
  float density = clamp(uCloudDensity, 0.0, 1.0);
  float softness = clamp(uCloudSoftness, 0.0, 1.0);

  float threshold = mix(0.76, 0.24, coverage);
  float feather = mix(0.035, 0.28, softness);
  float mask = smoothstep(threshold - feather, threshold + feather, cloudField);

  float verticalFade = smoothstep(0.02, 0.22, uv.y) * (1.0 - smoothstep(0.90, 1.0, uv.y));
  float horizonLift = smoothstep(0.03, 0.55, uv.y);
  float alpha = mask * verticalFade * mix(0.45, 1.25, density);
  alpha *= mix(0.78, 1.0, horizonLift);
  alpha = clamp(alpha, 0.0, 1.0) * clamp(uCloudOpacity, 0.0, 1.0);

  float highlight = smoothstep(threshold + feather * 0.15, threshold + feather + 0.22, cloudField);
  vec3 shadowTint = vec3(0.72, 0.78, 0.86);
  vec3 litTint = vec3(1.0, 0.985, 0.95);
  vec3 color = mix(shadowTint, litTint, highlight * 0.72 + 0.18);

  fragColor = vec4(color * alpha, alpha);
}
