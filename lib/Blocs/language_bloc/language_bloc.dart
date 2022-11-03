

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(LanguageInitial()) {
    on<LanguageEvent>((event, emit) {
      return emit(LanguageInitial());
    });

    on<ChangeLanguageEvent>((event, emit) {
      return emit(ChangeLanguageState(language: event.language));
    });

  }
}
