import 'package:flutter/material.dart';
import 'package:translater/repositery/model/language.dart';

@immutable
sealed class LanguageState {}

final class LanguageInitial extends LanguageState {}

class LanguageLoading extends LanguageState {}

class LanguageLoaded extends LanguageState {
  final List<LanguageModel> languages;
  LanguageLoaded(this.languages);
}

class LanguageError extends LanguageState {
  final String message;
  LanguageError(this.message);
}