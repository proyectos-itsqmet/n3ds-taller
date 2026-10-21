import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract final class AppEnv {
  static String get projectURL => dotenv.get('PROJECT_URL');
  static String get publishableKey => dotenv.get('PUBLISHABLE_KEY');
  static String get weatherKey => dotenv.get('WEATHER_KEY');
}
