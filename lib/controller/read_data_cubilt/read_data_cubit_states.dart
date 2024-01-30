import '../../model/words_model.dart';

abstract class ReadDataCubitStates {

}
class ReadDataCubitInitialState extends ReadDataCubitStates{}
class ReadDataCubitLoadingState extends ReadDataCubitStates{}
class ReadDataCubitSuccessState extends ReadDataCubitStates{
  final List<WordModel> words;
  ReadDataCubitSuccessState({required this.words});
}
class ReadDataCubitFailedState extends ReadDataCubitStates{

  final String messageError;
  ReadDataCubitFailedState({required this.messageError});
}