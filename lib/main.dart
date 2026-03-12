import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translater/bloc/translatebloc/bloc/translate_bloc.dart';
import 'package:translater/bloc/translatebloc/languagebloc/bloc/language_bloc.dart';
import 'package:translater/ui/homepage.dart';

const String basePath =
    'https://google-translate113.p.rapidapi.com/api/v1/translator/';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LanguageBloc()),
        BlocProvider(create: (context) => TranslateBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: Homepage(),
      ),
    );
  }
}
