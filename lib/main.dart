import 'package:clima_app/core/di/di.dart';
import 'package:clima_app/core/helpers/firebase_messaging_helper.dart';
import 'package:clima_app/src/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/helpers/timezone_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  TimeZoneConfig.initTimeZone();

  await dotenv.load(fileName: ".env");
  await initDependencies();

  /*FirebaseMessagingHelper.init();*/

  runApp(const MyApp());
}
