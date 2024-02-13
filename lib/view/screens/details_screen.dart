import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_words_local_data_base_use_hive/controller/read_data_cubit/read_data_cubit.dart';
import 'package:note_words_local_data_base_use_hive/controller/read_data_cubit/read_data_cubit_states.dart';
import 'package:note_words_local_data_base_use_hive/controller/write_data_cubit/write_data_cubit.dart';
import 'package:note_words_local_data_base_use_hive/model/words_model.dart';
import 'package:note_words_local_data_base_use_hive/view/styles/color_manager.dart';
import 'package:note_words_local_data_base_use_hive/view/widgets/exception_widget.dart';
import 'package:note_words_local_data_base_use_hive/view/widgets/udate_word_button.dart';
import '../widgets/upload_dailog.dart';
import '../widgets/word_info_widget.dart';

class WordDetailsScreen extends StatefulWidget {
  const WordDetailsScreen({super.key, required this.words});
  final WordModel words;

  @override
  State<WordDetailsScreen> createState() => _WordDetailsScreenState();
}

late WordModel _words;

class _WordDetailsScreenState extends State<WordDetailsScreen> {
  @override
  void initState() {
    _words = widget.words;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(context),
      body: BlocBuilder<ReadDataCubit, ReadDataCubitStates>(
        builder: (context, state) {
          if (state is ReadDataCubitSuccessState) {
            int index = state.words
                .indexWhere((element) => element.indexWord == _words.indexWord);
            _words = state.words[index];
            return _getSuccessBloc(context);
          } else if (state is ReadDataCubitFailedState) {
            return ExceptionWidget(
                iconData: Icons.error, text: state.messageError);
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: ColorsManager.whiteColor,
            ));
          }
        },
      ),
    );
  }

  ListView _getSuccessBloc(BuildContext context) {
    return ListView(
      children: [
        _getLabelText("Word"),
        WordInfoWidget(
          color: Color(_words.colorCode),
          text: _words.text,
          isArabic: _words.isArabic,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _getLabelText("Similar Words"),
            UpdateWordButton(
              color: Color(_words.colorCode),
              onTap: () => showDialog(
                context: context,
                builder: (context) => UploadDialog(
                    colorCode: _words.colorCode,
                    isExample: false,
                    indexInDatabase: _words.indexWord),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        for (int i = 0; i < _words.arabicSimilarWords.length; i++)
          WordInfoWidget(
              onPressed: () => _deleteArabicSimilarWord(i),
              color: Color(widget.words.colorCode),
              text: _words.arabicSimilarWords[i],
              isArabic: true),
        for (int i = 0; i < _words.englishSimilarWords.length; i++)
          WordInfoWidget(
              onPressed: () => _deleteEnglishSimilarWord(i),
              color: Color(widget.words.colorCode),
              text: _words.englishSimilarWords[i],
              isArabic: false),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _getLabelText("Examples"),
            UpdateWordButton(
              color: Color(_words.colorCode),
              onTap: () => showDialog(
                context: context,
                builder: (context) => UploadDialog(
                    colorCode: _words.colorCode,
                    isExample: true,
                    indexInDatabase: _words.indexWord),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        for (int i = 0; i < _words.arabicExamples.length; i++)
          WordInfoWidget(
              onPressed: () => _deleteArabicExample(i),
              color: Color(_words.colorCode),
              text: _words.arabicExamples[i],
              isArabic: true),
        for (int i = 0; i < _words.englishExamples.length; i++)
          WordInfoWidget(
              onPressed: () => _deleteEnglishExample(i),
              color: Color(_words.colorCode),
              text: _words.englishExamples[i],
              isArabic: false),
      ],
    );
  }

  Padding _getLabelText(String text) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(
                color: Color(widget.words.colorCode),
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ));
  }

  AppBar _getAppBar(context) {
    return AppBar(
      foregroundColor: Color(widget.words.colorCode),
      title: const Text("Details Screen"),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
              onPressed: () {
                _deleteWord(context);
              },
              icon: const Icon(Icons.delete)),
        )
      ],
      titleTextStyle:
          TextStyle(color: Color(widget.words.colorCode), fontSize: 22),
    );
  }

  void _deleteEnglishExample(int index) {
    WriteDataCubit.get(context).deleteExample(
      _words.indexWord,
      index,
      false,
    );
    ReadDataCubit.get(context).getWords();
  }

  void _deleteArabicExample(int index) {
    WriteDataCubit.get(context).deleteExample(
      _words.indexWord,
      index,
      true,
    );
    ReadDataCubit.get(context).getWords();
  }

  void _deleteEnglishSimilarWord(int index) {
    WriteDataCubit.get(context).deleteSimilarWord(
      _words.indexWord,
      index,
      false,
    );
    ReadDataCubit.get(context).getWords();
  }

  void _deleteArabicSimilarWord(int index) {
    WriteDataCubit.get(context).deleteSimilarWord(
      _words.indexWord,
      index,
      true,
    );
    ReadDataCubit.get(context).getWords();
  }

  void _deleteWord(BuildContext context) {
    WriteDataCubit.get(context).deleteWord(widget.words.indexWord);
    Navigator.pop(context);
  }
}
