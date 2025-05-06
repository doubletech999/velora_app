class AppConstants {
  // API Configuration
  static const String apiBaseUrl = 'https://api.velora.com/v1/';
  static const Duration apiTimeout = Duration(seconds: 30);
  
  // Storage Keys
  static const String languageKey = 'language';
  static const String userTokenKey = 'user_token';
  static const String firstLaunchKey = 'first_launch';
  
  // App Configuration
  static const String appName = 'Velora';
  static const String appVersion = '1.0.0';
  static const String appEmail = 'support@velora.com';
  
  // Map Configuration
  static const double defaultMapLatitude = 31.9522;
  static const double defaultMapLongitude = 35.2332;
  static const double defaultMapZoom = 8.0;
  
  // Image URLs (for development)
  static const String placeholderImage = 'https://placehold.co/400x300/556B2F/FFFFFF/png?text=Velora';
}