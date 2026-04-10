class AppConstants {
  AppConstants._();

  static const String appName = 'LMS Call';
  static const String appVersion = '1.0.0';

  // API
  static const String baseUrl = 'https://api.example.com/v1'; // Replace with actual API URL
  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Sync
  static const String syncWorkName = 'lms_call_sync_work';
  static const Duration syncInterval = Duration(minutes: 15);
  static const int maxSyncRetries = 3;
  static const int syncBatchSize = 50;

  // Local DB
  static const String dbName = 'lms_call.db';
  static const int dbVersion = 1;

  // Shared Prefs keys
  static const String prefOnboardingComplete = 'onboarding_complete';
  static const String prefLastSyncTime = 'last_sync_time';
  static const String prefAuthToken = 'auth_token';
  static const String prefUserId = 'user_id';
  static const String prefMobileNumber = 'mobile_number';
  static const String prefAuthUser = 'auth_user';
  static const String prefCallLogFetchDays = 'call_log_fetch_days';

  // Call log fetch
  static const int callLogFetchDays = 90; // Fetch last 90 days of call logs
  static const int callLogPageSize = 100;

  // Ring duration thresholds (seconds)
  static const int missedCallRingThreshold = 5;
}

class AppRoutes {
  AppRoutes._();

  static const String splash = '/';
  static const String permissions = '/permissions';
  static const String login = '/login';
  static const String otpVerify = '/otp-verify';
  static const String home = '/home';
  static const String callDetail = '/call-detail';
  static const String settings = '/settings';
  static const String search = '/search';
}
