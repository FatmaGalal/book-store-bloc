part of 'locale_bloc.dart';

@immutable
sealed class LocaleEvent {}

class ChangeLocale extends LocaleEvent {
  final Locale locale;

  ChangeLocale({required this.locale});
}
