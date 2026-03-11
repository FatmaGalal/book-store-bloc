part of 'locale_bloc.dart';

@immutable
sealed class LocaleState {}

final class LocaleInitial extends LocaleState {}

final class LocaleLoaded extends LocaleState {
  final Locale locale;

  LocaleLoaded({required this.locale});
}
