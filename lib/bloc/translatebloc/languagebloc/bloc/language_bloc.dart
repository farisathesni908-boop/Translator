import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:translater/bloc/translatebloc/languagebloc/bloc/language_state.dart';
import 'package:translater/repositery/api/language_api.dart';
import 'package:translater/repositery/model/language.dart';

part 'language_event.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final LanguageApi api = LanguageApi();

  LanguageBloc() : super(LanguageInitial()) {
    on<FetchLanguages>((event, emit) async {
      emit(LanguageLoading());

      try {
        final List<LanguageModel> languageList = await api.getLanguage();
        emit(LanguageLoaded(languageList));
      } catch (e) {
        emit(LanguageError(e.toString()));
      }
    });
  }
}

