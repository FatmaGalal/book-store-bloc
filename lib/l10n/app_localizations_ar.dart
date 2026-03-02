// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'متجر الكتب';

  @override
  String get loginTitle => 'تسجيل الدخول';

  @override
  String get signupTitle => 'إنشاء حساب';

  @override
  String get emailHint => 'البريد الإلكتروني';

  @override
  String get passwordHint => 'كلمة المرور';

  @override
  String get confirmPasswordHint => 'تأكيد كلمة المرور';

  @override
  String get noAccount => 'ليس لديك حساب!';

  @override
  String get haveAccount => 'لديك حساب بالفعل!';

  @override
  String get detailsTitle => 'تفاصيل الكتاب';

  @override
  String get author => 'المؤلف';

  @override
  String get description => 'الوصف';

  @override
  String get publisher => 'الناشر';

  @override
  String get published => 'تاريخ النشر';

  @override
  String get language => 'اللغة';

  @override
  String get bookId => 'رقم الكتاب';

  @override
  String get unknown => 'غير معروف';

  @override
  String get general => 'عام';

  @override
  String get favoritesTitle => 'مفضلاتي';
}
