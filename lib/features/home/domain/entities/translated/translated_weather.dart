class TranslatedWeather {
  final String code;
  final String description;
  final String? icon;
  final String? main;

  TranslatedWeather({
    required this.code,
    required this.description,
    this.icon,
    this.main,
  });

  factory TranslatedWeather.fromJson(Map<String, dynamic> json) {
    return TranslatedWeather(
      code: json['code'],
      description: json['description'],
    );
  }

  TranslatedWeather copyWith({
    String? code,
    String? translatedDescription,
    String? icon,
    String? main,
  }) {
    return TranslatedWeather(
      code: code ?? this.code,
      description: translatedDescription ?? description,
      icon: icon ?? this.icon,
      main: main ?? this.main,
    );
  }
}
