part of 'language_bloc.dart';

@immutable
abstract class LanguageEvent {}

class ChangeLanguageEvent extends LanguageEvent {

  String language;

  ChangeLanguageEvent({required this.language});

}
