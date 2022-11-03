part of 'language_bloc.dart';

@immutable
abstract class LanguageState {}

class LanguageInitial extends LanguageState {}

class ChangeLanguageState extends LanguageState {

  String language;
  ChangeLanguageState({required this.language});

}
