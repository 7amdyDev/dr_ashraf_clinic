// lib/config/app_config.dart
abstract class AppConfig {
  static const String apiUrl = String.fromEnvironment(
    'API_URL',
    //  defaultValue: 'http://localhost:3001', // Default for local dev/no define
  );

  // Add other environment-specific variables here
  static const String firebaseDb = String.fromEnvironment(
    'DB_URL',
    // defaultValue: 'default_value',
  );

  static const String clientId = String.fromEnvironment(
    'ClientId',
    //  defaultValue: 'default_value',
  );
}
