class TranslatedWeather {
  final String code;
  final String translatedDescription;
  final String? icon;
  final String? main;

  TranslatedWeather({
    required this.code,
    required this.translatedDescription,
    this.icon,
    this.main,
  });

  factory TranslatedWeather.fromJson(Map<String, dynamic> json) {
    return TranslatedWeather(
      code: json['code'],
      translatedDescription: json['description'],
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
      translatedDescription:
          translatedDescription ?? this.translatedDescription,
      icon: icon ?? this.icon,
      main: main ?? this.main,
    );
  }
}
