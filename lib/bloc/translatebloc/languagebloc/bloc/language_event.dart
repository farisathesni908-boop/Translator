part of 'language_bloc.dart';

@immutable
sealed class LanguageEvent {}

class loadlanguage extends LanguageEvent {}


class FetchLanguages extends LanguageEvent {}