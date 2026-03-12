import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:translater/repositery/api/apiservice/Translate_api.dart';
import 'package:translater/repositery/model/translatemodel.dart';


part 'translate_event.dart';
part 'translate_state.dart';

class TranslateBloc extends Bloc<TranslateEvent, TranslateState> {
  TranslateApi translateApi=TranslateApi();
  late TranslateModel translateModel;
  TranslateBloc() : super(TranslateInitial()) {
    on<FetchTranslate>((event, emit)async{
      emit(Translateloading());
      try{

        translateModel =await translateApi.getTranslate(event.message,event.code);
        emit(Translateloaded(translateModel));
      }catch(e){
        print(e);
        emit(TranslateError( e.toString()));
      }

    });
  }
}