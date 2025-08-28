// lib/core/localization/app_localizations.dart
import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      // App basics
      'app_name': 'Velora',
      'welcome': 'Welcome to Velora',
      'discover_palestine': 'Discover Palestine',
      'home': 'Home',
      'paths': 'Paths',
      'explore': 'Explore',
      'map': 'Map',
      'profile': 'Profile',
      
      // Home screen
      'featured_paths': 'Featured Paths',
      'suggested_adventures': 'Suggested Adventures',
      'search_placeholder': 'Search for a path or place...',
      'view_all': 'View All',
      
      // Path details
      'easy': 'Easy',
      'medium': 'Medium',
      'hard': 'Hard',
      'hours': 'hours',
      'km': 'km',
      'start_journey': 'Start Journey',
      'description': 'Description',
      'available_activities': 'Available Activities',
      'warnings_and_tips': 'Warnings and Tips',
      'rating': 'Rating',
      'reviews': 'reviews',
      
      // Locations
      'north': 'North',
      'center': 'Center',
      'south': 'South',
      
      // Activities
      'hiking': 'Hiking',
      'camping': 'Camping',
      'climbing': 'Climbing',
      'religious': 'Religious',
      'cultural': 'Cultural',
      'nature': 'Nature',
      'archaeological': 'Archaeological',
      
      // Profile
      'my_trips': 'My Trips',
      'saved': 'Saved',
      'achievements': 'Achievements',
      'favorites': 'Favorites',
      'language': 'Language',
      'help_support': 'Help & Support',
      'about_app': 'About App',
      'logout': 'Logout',
      'completed_trips': 'Completed Trips',
      'saved_trips': 'Saved Trips',
      'settings': 'Settings',
      
      // Filter and search
      'filters': 'Filters',
      'activity_type': 'Activity Type',
      'difficulty_level': 'Difficulty Level',
      'location': 'Location',
      'apply': 'Apply',
      'clear_all': 'Clear All',
      'no_paths_available': 'No paths available',
      
      // Common actions
      'save': 'Save',
      'cancel': 'Cancel',
      'delete': 'Delete',
      'edit': 'Edit',
      'share': 'Share',
      'close': 'Close',
      'back': 'Back',
      'next': 'Next',
      'done': 'Done',
      'loading': 'Loading...',
      'error': 'Error',
      'success': 'Success',
      
      // Settings
      'notifications': 'Notifications',
      'dark_mode': 'Dark Mode',
      'map_type': 'Map Type',
      'temperature_unit': 'Temperature Unit',
      'location_services': 'Location Services',
      'search_history': 'Search History',
      'reset_settings': 'Reset Settings',
      'account': 'Account',
      'app_settings': 'App Settings',
      'support': 'Support',
      
      // Authentication
      'login': 'Login',
      'register': 'Register',
      'email': 'Email',
      'password': 'Password',
      'confirm_password': 'Confirm Password',
      'full_name': 'Full Name',
      'phone_number': 'Phone Number',
      'forgot_password': 'Forgot Password?',
      'remember_me': 'Remember Me',
      'login_as_guest': 'Login as Guest',
      'create_account': 'Create Account',
      'already_have_account': 'Already have an account?',
      'dont_have_account': 'Don\'t have an account?',
      
      // Onboarding
      'explore_palestine_title': 'Explore Palestine',
      'explore_palestine_desc': 'Discover the most beautiful routes and tourist areas in Palestine, in an easy and simple way.',
      'diverse_paths_title': 'Diverse Paths',
      'diverse_paths_desc': 'A variety of paths suitable for all levels and interests, from simple walking to difficult climbing.',
      'plan_trip_title': 'Plan Your Trip',
      'plan_trip_desc': 'Save your favorite routes, view path details and coordinates, and share your experiences with others.',
      'get_started': 'Get Started',
      'skip': 'Skip',
      
      // Errors and validation
      'email_required': 'Email is required',
      'invalid_email': 'Invalid email',
      'password_required': 'Password is required',
      'password_too_short': 'Password must be at least 6 characters',
      'name_required': 'Name is required',
      'name_too_short': 'Name must be at least 3 characters',
      'phone_required': 'Phone number is required',
      'invalid_phone': 'Invalid phone number',
      'passwords_dont_match': 'Passwords don\'t match',
      'login_failed': 'Login failed',
      'registration_failed': 'Registration failed',
      'logout_failed': 'Logout failed',
      'network_error': 'Network error',
      'something_went_wrong': 'Something went wrong',
      
      // Success messages
      'login_successful': 'Login successful',
      'registration_successful': 'Registration successful',
      'profile_updated': 'Profile updated successfully',
      'path_saved': 'Path saved',
      'path_removed': 'Path removed from saved',
      
      // Map and location
      'your_location': 'Your Location',
      'path_start': 'Path Start',
      'path_end': 'Path End',
      'distance': 'Distance',
      'duration': 'Duration',
      'elevation': 'Elevation',
      'current_location': 'Current Location',
      'show_full_map': 'Show Full Map',
      
      // Time and date
      'today': 'Today',
      'yesterday': 'Yesterday',
      'days_ago': 'days ago',
      'weeks_ago': 'weeks ago',
      'months_ago': 'months ago',
      'just_now': 'Just now',
      'minutes_ago': 'minutes ago',
      'hours_ago': 'hours ago',
      
      // Stats and numbers
      'total_distance': 'Total Distance',
      'total_time': 'Total Time',
      'completed': 'Completed',
      'in_progress': 'In Progress',
      'not_started': 'Not Started',
      'difficulty_easy': 'Easy',
      'difficulty_medium': 'Medium',
      'difficulty_hard': 'Hard',
    },
    'ar': {
      // App basics
      'app_name': 'Velora',
      'welcome': 'مرحباً في Velora',
      'discover_palestine': 'اكتشف فلسطين',
      'home': 'الرئيسية',
      'paths': 'المسارات',
      'explore': 'استكشف',
      'map': 'الخريطة',
      'profile': 'الملف',
      
      // Home screen
      'featured_paths': 'مسارات مميزة',
      'suggested_adventures': 'مغامرات مقترحة',
      'search_placeholder': 'ابحث عن مسار أو مكان...',
      'view_all': 'عرض الكل',
      
      // Path details
      'easy': 'سهل',
      'medium': 'متوسط',
      'hard': 'صعب',
      'hours': 'ساعات',
      'km': 'كم',
      'start_journey': 'ابدأ الرحلة',
      'description': 'الوصف',
      'available_activities': 'الأنشطة المتاحة',
      'warnings_and_tips': 'تحذيرات وإرشادات',
      'rating': 'التقييم',
      'reviews': 'تقييمات',
      
      // Locations
      'north': 'الشمال',
      'center': 'الوسط',
      'south': 'الجنوب',
      
      // Activities
      'hiking': 'المشي',
      'camping': 'التخييم',
      'climbing': 'التسلق',
      'religious': 'ديني',
      'cultural': 'ثقافي',
      'nature': 'طبيعة',
      'archaeological': 'أثري',
      
      // Profile
      'my_trips': 'رحلاتي',
      'saved': 'المحفوظات',
      'achievements': 'الإنجازات',
      'favorites': 'المفضلة',
      'language': 'اللغة',
      'help_support': 'المساعدة والدعم',
      'about_app': 'عن التطبيق',
      'logout': 'تسجيل الخروج',
      'completed_trips': 'رحلات مكتملة',
      'saved_trips': 'رحلات محفوظة',
      'settings': 'الإعدادات',
      
      // Filter and search
      'filters': 'الفلاتر',
      'activity_type': 'نوع النشاط',
      'difficulty_level': 'مستوى الصعوبة',
      'location': 'الموقع',
      'apply': 'تطبيق',
      'clear_all': 'مسح الكل',
      'no_paths_available': 'لا توجد مسارات متاحة',
      
      // Common actions
      'save': 'حفظ',
      'cancel': 'إلغاء',
      'delete': 'حذف',
      'edit': 'تعديل',
      'share': 'مشاركة',
      'close': 'إغلاق',
      'back': 'رجوع',
      'next': 'التالي',
      'done': 'تم',
      'loading': 'جاري التحميل...',
      'error': 'خطأ',
      'success': 'نجح',
      
      // Settings
      'notifications': 'الإشعارات',
      'dark_mode': 'الوضع الداكن',
      'map_type': 'نوع الخريطة',
      'temperature_unit': 'وحدة درجة الحرارة',
      'location_services': 'خدمات الموقع',
      'search_history': 'سجل البحث',
      'reset_settings': 'إعادة تعيين الإعدادات',
      'account': 'الحساب',
      'app_settings': 'إعدادات التطبيق',
      'support': 'الدعم',
      
      // Authentication
      'login': 'تسجيل الدخول',
      'register': 'إنشاء حساب',
      'email': 'البريد الإلكتروني',
      'password': 'كلمة المرور',
      'confirm_password': 'تأكيد كلمة المرور',
      'full_name': 'الاسم الكامل',
      'phone_number': 'رقم الهاتف',
      'forgot_password': 'نسيت كلمة المرور؟',
      'remember_me': 'تذكرني',
      'login_as_guest': 'الدخول كضيف',
      'create_account': 'إنشاء حساب',
      'already_have_account': 'لديك حساب بالفعل؟',
      'dont_have_account': 'ليس لديك حساب؟',
      
      // Onboarding
      'explore_palestine_title': 'استكشف فلسطين',
      'explore_palestine_desc': 'اكتشف أجمل المسارات والمناطق السياحية في فلسطين، بطريقة سهلة ومبسطة.',
      'diverse_paths_title': 'تنوع المسارات',
      'diverse_paths_desc': 'مجموعة متنوعة من المسارات المناسبة لجميع المستويات والاهتمامات، من المشي البسيط إلى التسلق الصعب.',
      'plan_trip_title': 'خطط رحلتك',
      'plan_trip_desc': 'احفظ المسارات المفضلة لديك، واطلع على تفاصيل الطرق والإحداثيات، وشارك تجاربك مع الآخرين.',
      'get_started': 'ابدأ الآن',
      'skip': 'تخطي',
      
      // Errors and validation
      'email_required': 'البريد الإلكتروني مطلوب',
      'invalid_email': 'البريد الإلكتروني غير صالح',
      'password_required': 'كلمة المرور مطلوبة',
      'password_too_short': 'كلمة المرور يجب أن تكون 6 أحرف على الأقل',
      'name_required': 'الاسم مطلوب',
      'name_too_short': 'الاسم يجب أن يكون 3 أحرف على الأقل',
      'phone_required': 'رقم الهاتف مطلوب',
      'invalid_phone': 'رقم الهاتف غير صالح',
      'passwords_dont_match': 'كلمات المرور غير متطابقة',
      'login_failed': 'فشل تسجيل الدخول',
      'registration_failed': 'فشل التسجيل',
      'logout_failed': 'فشل تسجيل الخروج',
      'network_error': 'خطأ في الشبكة',
      'something_went_wrong': 'حدث خطأ ما',
      
      // Success messages
      'login_successful': 'تم تسجيل الدخول بنجاح',
      'registration_successful': 'تم التسجيل بنجاح',
      'profile_updated': 'تم تحديث الملف الشخصي بنجاح',
      'path_saved': 'تم حفظ المسار',
      'path_removed': 'تم إزالة المسار من المحفوظات',
      
      // Map and location
      'your_location': 'موقعك الحالي',
      'path_start': 'بداية المسار',
      'path_end': 'نهاية المسار',
      'distance': 'المسافة',
      'duration': 'المدة',
      'elevation': 'الارتفاع',
      'current_location': 'الموقع الحالي',
      'show_full_map': 'عرض الخريطة بشكل كامل',
      
      // Time and date
      'today': 'اليوم',
      'yesterday': 'أمس',
      'days_ago': 'أيام مضت',
      'weeks_ago': 'أسابيع مضت',
      'months_ago': 'أشهر مضت',
      'just_now': 'الآن',
      'minutes_ago': 'دقائق مضت',
      'hours_ago': 'ساعات مضت',
      
      // Stats and numbers
      'total_distance': 'إجمالي المسافة',
      'total_time': 'إجمالي الوقت',
      'completed': 'مكتمل',
      'in_progress': 'قيد التنفيذ',
      'not_started': 'لم يبدأ',
      'difficulty_easy': 'سهل',
      'difficulty_medium': 'متوسط',
      'difficulty_hard': 'صعب',
    },
  };

  String get(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }
  
  // إضافة دعم مباشر للنصوص
  String text(String key) => get(key);
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}