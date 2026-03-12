// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:translater/bloc/translatebloc/bloc/translate_bloc.dart';
import 'package:translater/bloc/translatebloc/languagebloc/bloc/language_bloc.dart';
import 'package:translater/bloc/translatebloc/languagebloc/bloc/language_state.dart';
import 'package:translater/repositery/model/language.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String selectedValue = "en";
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<LanguageBloc>().add(FetchLanguages());
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Text Copied")));
  }

  void translateText() {
    if (textController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Enter text to translate")),
      );
      return;
    }

    context.read<TranslateBloc>().add(
          FetchTranslate(
            message: textController.text.toString(),
            code: selectedValue,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Translator", style: TextStyle(fontSize: 28)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            /// Language Selection
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Choose Language",
                      style: TextStyle(fontSize: 16)),
                  BlocBuilder<LanguageBloc, LanguageState>(
                    builder: (context, state) {
                      if (state is LanguageLoading) {
                        return const CircularProgressIndicator();
                      }
                      if (state is LanguageLoaded) {
                        final data = state.languages;

                        return SizedBox(
                          width: 150,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectedValue,
                            hint: const Text("Language"),
                            items: data.map<DropdownMenuItem<String>>(
                              (LanguageModel item) {
                                return DropdownMenuItem<String>(
                                  value: item.code,
                                  child: Text(item.language),
                                );
                              },
                            ).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                selectedValue = newValue!;
                              });
                            },
                          ),
                        );
                      }
                      if (state is LanguageError) {
                        return const Text('Failed to load');
                      }
                      return const SizedBox();
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// Input Box
            Container(
              height: 200,
              width: 350,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(border: Border.all(width: 1)),
              child: Column(
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      decoration: const InputDecoration(
                        hintText: "Write the text",
                        border: InputBorder.none,
                      ),
                      maxLines: null,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.copy),
                        onPressed: () => copyToClipboard(textController.text),
                      ),
                      IconButton(
                        icon: const Icon(Icons.mic),
                        onPressed: () => debugPrint("Voice Clicked"),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            /// Translate Button
            SizedBox(
              width: 350,
              child: Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: translateText,
                  child: const Text("Translate"),
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Padding(
              padding: EdgeInsets.only(right: 250),
              child: Text("Response / Result"),
            ),

            const SizedBox(height: 10),

            /// Result Box
            BlocBuilder<TranslateBloc, TranslateState>(
              builder: (context, state) {
                if (state is Translateloading) {
                  return const CircularProgressIndicator();
                }

                if (state is Translateloaded) {
                  return Container(
                    height: 200,
                    width: 350,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(border: Border.all(width: 1)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Text(
                              state.translate.data!.translations!.first.translatedText.toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.copy),
                              onPressed: () =>
                                  copyToClipboard(state.translate.toString()),
                            ),
                            IconButton(
                              icon: const Icon(Icons.mic),
                              onPressed: () =>
                                  debugPrint("Voice Clicked"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }

                if (state is TranslateError) {
                  return const Text('Translation failed');
                }

                return const SizedBox(
                  height: 200,
                  width: 350,
                );
              },
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}