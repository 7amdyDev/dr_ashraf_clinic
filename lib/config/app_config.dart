// lib/config/app_config.dart
abstract class AppConfig {
  static const String apiUrl = String.fromEnvironment(
    'API_URL',
    // defaultValue:
    //     'https://api.ashrafyehia.al-iyada.com', // Default for local dev/no define
  );

  // Add other environment-specific variables here
  static const String firebaseDb = String.fromEnvironment(
    'DB_URL',
    //  defaultValue: 'https://ashrafyehiaclinic-default-rtdb.firebaseio.com/',
  );

  static const String clientId = String.fromEnvironment(
    'ClientId',
    //  defaultValue: 'AyClinics',
  );
}
