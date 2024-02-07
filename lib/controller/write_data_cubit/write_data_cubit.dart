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
  void addSimilarWord(int indexInDatabase){
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFromDatabase();
      words[indexInDatabase] = words[indexInDatabase].addSimilarWord(text, isArabic);
      box.put(HiveConstants.hiveList, words);
    }, "We Have Problems when add similar word , please try again");
  }
  void addExample(int indexInDatabase){
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFromDatabase();
      words[indexInDatabase] = words[indexInDatabase].addNewExample(text, isArabic);
      box.put(HiveConstants.hiveList, words);
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
  }
  void updateColorCode(int colorCode) {
    this.colorCode = colorCode;
    emit(WriteDataCubitInitialState());
  }
  void updateIsArabic(bool isArabic) {
    this.isArabic = isArabic;
    print("the bool arabic ${isArabic}");
    emit(WriteDataCubitInitialState());
  }
  void addNewWord(){
    emit(WriteDataCubitLoadingState());
    _tryAndCatchBlock(() {

      List<WordModel> words = _getWordsFromDatabase();
    words.add(WordModel(indexWord: words.length, colorCode: colorCode, isArabic: isArabic, text: text));
      print("success in getword ${words}");

    box.put(HiveConstants.hiveList, words);
    },
        "We Have Problems when add word , please try again");
  }
  void deleteWord(int indexDatabase){
    emit(WriteDataCubitLoadingState());
    _tryAndCatchBlock(() {
      List<WordModel> words = _getWordsFromDatabase();
      words.removeAt(indexDatabase);
      for(int i = 0 ; i < words.length ; i++ ){
        words[i] = words[i].decrementIndexInDataBase();
      }
      box.put(HiveConstants.hiveList, words);
    }, "We Have Problems when delete word , please try again");
    }
  void _tryAndCatchBlock(VoidCallback methodToExecute,String message ){
    emit(WriteDataCubitLoadingState());
    try{
      methodToExecute;
      emit(WriteDataCubitSuccessState());
    }catch(error){
      emit(WriteDataCubitFailedState(messageError: message));
    }
  }
  _getWordsFromDatabase()=>List.from(box.get(HiveConstants.hiveList,defaultValue: [])).cast<WordModel>();
}
