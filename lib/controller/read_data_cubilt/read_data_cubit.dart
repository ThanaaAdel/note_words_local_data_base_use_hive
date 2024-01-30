import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:note_words_local_data_base_use_hive/controller/read_data_cubilt/read_data_cubit_states.dart';
import 'package:note_words_local_data_base_use_hive/hive_constants/hive_constants.dart';

class ReadDataCubit extends Cubit<ReadDataCubitStates>{
  ReadDataCubit():super(ReadDataCubitInitialState());
  static get(context) =>BlocProvider.of(context);
  final Box _box = Hive.box(HiveConstants.hiveBoxName);
   LanguageFilter languageFilter = LanguageFilter.allWords;
   SortingBy sortingBy = SortingBy.time;
   SortingType sortingType = SortingType.descending;
  void updateLanguageFilter(LanguageFilter languageFilter){
    this.languageFilter = languageFilter;
  }
  void updateSortedType(SortingType sortingType){
    this.sortingType=sortingType;
  }
  void updateSortingBy(SortingBy sortingBy){
    this.sortingBy = sortingBy;
  }

}
enum LanguageFilter{
  arabicOnly,
  englishOnly,
  allWords,
}
enum SortingBy{
  time,
  wordLength,
}
enum SortingType{
  ascending,
  descending
}