import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart';

class ApiConfig {
  ApiConfig._();

  static String get jamendoKey {
    // 1. Try terminal flag (Production)
    const key = String.fromEnvironment('JAMENDO_KEY');
    if (key.isNotEmpty) return key;

    // 2. Try .env file (Development) - Checking both common names
    final envKey = dotenv.env['JAMENDO_KEY'] ?? dotenv.env['JAMENDO_API_KEY'];

    if (envKey == null || envKey.isEmpty) {
      if (kDebugMode) {
        print(
          '❌ ApiConfig: No API Key found in .env! Make sure you have JAMENDO_KEY=xxxx',
        );
      }
      return '';
    }

    return envKey;
  }
}
