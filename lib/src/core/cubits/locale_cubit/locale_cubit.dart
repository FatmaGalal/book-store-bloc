import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit() : super(LocaleState(Locale('en')));
  void setLocale(Locale newLocale) {
    emit(LocaleState(newLocale));
  }
}
