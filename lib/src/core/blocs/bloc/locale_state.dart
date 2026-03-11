part of 'locale_bloc.dart';

@immutable
sealed class LocaleState {}

final class LocaleSwitched extends LocaleState {
  final Locale locale;

  LocaleSwitched({required this.locale});
}
