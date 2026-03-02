// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'BOOK STORE';

  @override
  String get loginTitle => 'Login';

  @override
  String get signupTitle => 'Sign Up';

  @override
  String get emailHint => 'Email';

  @override
  String get passwordHint => 'Password';

  @override
  String get confirmPasswordHint => 'Confirm Password';

  @override
  String get noAccount => 'You don\'t have an account!';

  @override
  String get haveAccount => 'You already have an account!';

  @override
  String get detailsTitle => 'Book Details';

  @override
  String get author => 'Author';

  @override
  String get description => 'Description';

  @override
  String get publisher => 'Publisher';

  @override
  String get published => 'Published';

  @override
  String get language => 'Language';

  @override
  String get bookId => 'Book ID';

  @override
  String get unknown => 'Unknown';

  @override
  String get general => 'General';

  @override
  String get favoritesTitle => 'My Favorites';
}
