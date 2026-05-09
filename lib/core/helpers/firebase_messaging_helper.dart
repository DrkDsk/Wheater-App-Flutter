import 'package:clima_app/core/di/di.dart';
import 'package:clima_app/core/helpers/app_preferences.dart';
import 'package:clima_app/core/helpers/timezone_config.dart';
import 'package:clima_app/core/helpers/weather_helper.dart';
import 'package:clima_app/features/favorites/data/datasources/favorite_weather_datasource.dart';
import 'package:clima_app/features/home/domain/usecases/get_weather_use_case.dart';
import 'package:clima_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FirebaseMessagingHelper {
  static Future init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseMessagingHelper.checkForInitialMessage();
    FirebaseMessagingHelper.setOpenedAppMessageHandler();
    FirebaseMessagingHelper.setListenMessageHandler();
    FirebaseMessagingHelper.setBackgroundMessageHandler();
  }

  static Future requestFirebaseMessagingPermissions() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }

  static Future registerFirebaseToken() async {
    String _ = await FirebaseMessaging.instance.getToken() ?? "";
  }

  static Future checkForInitialMessage() async {
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      firebaseMessageHandler(initialMessage);
    }
  }

  static Future handleRecommendation() async {
    final cityWeatherDataResult = getIt<GetWeatherUseCase>();
    final locationCacheService = getIt<FavoriteWeatherDataSource>();

    final location = await locationCacheService.getStoredLocationCache();
    final lat = location?.latitude;
    final lon = location?.longitude;

    final result = await cityWeatherDataResult.call(
      latitude: lat,
      longitude: lon,
    );

    result.fold((left) {}, (result) {
      final hourly = result.forecast.hourly.take(7).last;

      final temp = hourly.temp;
      final feelsLike = hourly.feelsLike;
      final pressure = hourly.pressure;
      final humidity = hourly.humidity;
      final pop = hourly.pop;
      final weatherDescription = hourly.weather.first.main;

      if (temp == null ||
          feelsLike == null ||
          pressure == null ||
          humidity == null ||
          pop == null ||
          weatherDescription == null) {
        return;
      }

      final _ = WeatherHelper.generateWeatherRecommendation(
        temp: temp,
        feelsLike: feelsLike,
        pressure: pressure,
        humidity: humidity,
        weatherDescription: weatherDescription,
        pop: pop,
      );
    });
  }

  static Future firebaseMessageHandler(RemoteMessage remoteMessage) async {
    final String notificationTitle = remoteMessage.notification?.title ?? "";
    final String notificationBody = remoteMessage.notification?.body ?? "";
    final notificationData = remoteMessage.data;
    final notificationId = notificationData["id"] ?? "";

    if (notificationTitle.isNotEmpty && notificationBody.isNotEmpty) {
      if (notificationId == "night_request") {
        handleRecommendation();
      }
    }
  }

  static setListenMessageHandler() {
    FirebaseMessaging.onMessage.listen(firebaseMessageHandler);
  }

  static setOpenedAppMessageHandler() {
    FirebaseMessaging.onMessageOpenedApp.listen(firebaseMessageHandler);
  }

  static setBackgroundMessageHandler() {
    FirebaseMessaging.onBackgroundMessage(_backgroundMessageHandler);
  }
}

@pragma('vm:entry-point')
Future _backgroundMessageHandler(RemoteMessage message) async {
  await AppPreferences().init();

  final initialization = AppPreferences.getInitialization();

  if (initialization == null || !initialization) {
    WidgetsFlutterBinding.ensureInitialized();
    TimeZoneConfig.initTimeZone();

    await dotenv.load(fileName: ".env");
    await initDependencies();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    AppPreferences.setInitialization(true);
  }

  FirebaseMessagingHelper.firebaseMessageHandler(message);
}
