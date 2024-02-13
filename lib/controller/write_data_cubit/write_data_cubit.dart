import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:note_words_local_data_base_use_hive/controller/write_data_cubit/write_data_cubit_states.dart';
import 'package:note_words_local_data_base_use_hive/hive_constants/hive_constants.dart';
import 'package:note_words_local_data_base_use_hive/model/words_model.dart';

class WriteDataCubit extends Cubit<WriteDataCubitStates> {
  WriteDataCubit() : super(WriteDataCubitInitialState());
 static WriteDataCubit get(context) => BlocProvider.of(context);

  final Box box = Hive.box(HiveConstants.hiveBoxName);
  String text = '';
  int colorCode = 0xff4A47A3;
  bool isArabic = true;
  void deleteWord(int indexAtDatabase){
    _tryAndCatchBlock((){
      List<WordModel>words=_getWordsFromDatabase();
      words.removeAt(indexAtDatabase);
      for (var i = indexAtDatabase; i < words.length; i++) {
        words[i]=words[i].decrementIndexInDataBase();
      }
      box.put(HiveConstants.hiveList, words);
    },
      "We Have problems when we Delete word,Please try again",
    );

  }
  void addWord() {
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFromDatabase();
      words.add(WordModel(indexWord: words.length, text: text, isArabic: isArabic, colorCode: colorCode));
      box.put(HiveConstants.hiveList, words);
    }, "We have problems when we add a word. Please try again.");
  }
  void addSimilarWord(int indexInDatabase){
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFromDatabase();
      words[indexInDatabase] = words[indexInDatabase].addSimilarWord(text, isArabic);
      box.put(HiveConstants.hiveList, words);
print(words.length);
    }, "We Have Problems when add similar word , please try again");
  }
  void addExample(int indexInDatabase){
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFromDatabase();
      words[indexInDatabase] = words[indexInDatabase].addNewExample(text, isArabic);
      box.put(HiveConstants.hiveList, words);
      print( words[indexInDatabase]);

    }, "We Have Problems when add Example , please try again");
  }
  void deleteExample(int indexInDatabase, int indexExample,bool isArabicExample){
 _tryAndCatchBlock(() {
   List<WordModel> words = _getWordsFromDatabase();
   words[indexInDatabase] = words[indexInDatabase].deleteExampleWord(indexExample, isArabicExample);
   box.put(HiveConstants.hiveList, words);
 }, "We Have Problems when delete Example , please try again");
  }
  void deleteSimilarWord(int indexInDatabase, int indexSimilarWord,bool isArabicSimilarWord){
_tryAndCatchBlock(() {
  List<WordModel> words = _getWordsFromDatabase();
  words[indexInDatabase] = words[indexInDatabase].deleteSimilarWord(indexSimilarWord, isArabicSimilarWord);
  box.put(HiveConstants.hiveList, words);

}, "We Have Problems when delete similar word , please try again");
  }
  void updateText(String text) {
    this.text = text;
    emit(WriteDataCubitInitialState());

  }

  void updateColorCode(int colorCode) {
    this.colorCode = colorCode;
    emit(WriteDataCubitInitialState());
  }
  void updateIsArabic(bool isArabic) {
    this.isArabic = isArabic;
    emit(WriteDataCubitInitialState());
  }




  Future<void> _tryAndCatchBlock(VoidCallback methodToExcute, String message) async {
    emit(WriteDataCubitLoadingState());
    try {
      methodToExcute.call();
      emit(WriteDataCubitSuccessState());
    } catch (error) {
      emit(WriteDataCubitFailedState(messageError: message));
    }
  }

  List<WordModel> _getWordsFromDatabase()=>List.from(box.get(HiveConstants.hiveList,defaultValue: []));

}
