import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:note_words_local_data_base_use_hive/controller/read_data_cubilt/read_data_cubit_states.dart';
import 'package:note_words_local_data_base_use_hive/hive_constants/hive_constants.dart';
import 'package:note_words_local_data_base_use_hive/model/words_model.dart';

class ReadDataCubit extends Cubit<ReadDataCubitStates> {
  ReadDataCubit() : super(ReadDataCubitInitialState());
  static ReadDataCubit get(context) => BlocProvider.of(context);
  final Box _box = Hive.box(HiveConstants.hiveBoxName);
  LanguageFilter languageFilter = LanguageFilter.allWords;
  SortingBy sortingBy = SortingBy.time;
  SortingType sortingType = SortingType.ascending;
  void getWords() {
    emit(ReadDataCubitLoadingState());
    try {
      List<WordModel> wordsToReturn =
          List.from(_box.get(HiveConstants.hiveList, defaultValue: [])).cast<WordModel>();
      _removeUnWantedWords(wordsToReturn);
      _applySorting(wordsToReturn);
      for(var i = 0; i < wordsToReturn.length ; i++ ){
        print("============================================");
        print(wordsToReturn[i].text);
        print(wordsToReturn[i].indexWord);
        print(wordsToReturn[i].isArabic);
        print(wordsToReturn[i].colorCode);
      }
      emit(ReadDataCubitSuccessState(words: wordsToReturn));
    } catch (error) {
      emit(ReadDataCubitFailedState(
          messageError: "We have Problem at get , Please try again"));
    }
  }

  void _removeUnWantedWords(List<WordModel> wordsToReturn) {
    if (languageFilter == LanguageFilter.allWords) {
      return;
    }
    for (int i = 0; i < wordsToReturn.length; i++) {
      if ((languageFilter == LanguageFilter.arabicOnly &&
              wordsToReturn[i].isArabic == false) ||
          (languageFilter == LanguageFilter.englishOnly &&
              wordsToReturn[i].isArabic == true)) {
        wordsToReturn.removeAt(i);
        i--;
      }
    }
  }

  void _applySorting(List<WordModel> wordsToReturn) {
    if (sortingBy == SortingBy.time) {
      if (sortingType == SortingType.ascending) {
        return;
      } else {
        _reverse(wordsToReturn);
      }
    }
    else{
    wordsToReturn.sort((WordModel a,WordModel b) => a.text.length.compareTo(b.text.length));
    if(sortingType == SortingType.ascending) {return ;}

    else{
      _reverse(wordsToReturn);
    }
    }
  }

  void _reverse(List<WordModel> wordsToReturn) {
    for (int i = 0; i < wordsToReturn.length / 2; i++) {
      WordModel temp = wordsToReturn[i];
      wordsToReturn[i] = wordsToReturn[wordsToReturn.length - 1 - i];
      wordsToReturn[wordsToReturn.length - 1 - i] = temp;
    }
  }

  void updateLanguageFilter(LanguageFilter languageFilter) {
    this.languageFilter = languageFilter;
  }

  void updateSortedType(SortingType sortingType) {
    this.sortingType = sortingType;
  }

  void updateSortingBy(SortingBy sortingBy) {
    this.sortingBy = sortingBy;
  }
}

enum LanguageFilter {
  arabicOnly,
  englishOnly,
  allWords,
}

enum SortingBy {
  time,
  wordLength,
}

enum SortingType { ascending, descending }
