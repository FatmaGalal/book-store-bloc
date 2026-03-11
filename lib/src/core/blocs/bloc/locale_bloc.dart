import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'locale_event.dart';
part 'locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  LocaleBloc() : super(LocaleInitial()) {
    on<LocaleEvent>((event, emit) {
      if (event is ChangeLocale) {
        emit(LocaleLoaded(locale: event.locale));
      }
    });
  }
}
