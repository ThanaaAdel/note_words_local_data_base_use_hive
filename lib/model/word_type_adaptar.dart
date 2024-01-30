import 'package:hive_flutter/hive_flutter.dart';
import 'package:note_words_local_data_base_use_hive/model/words_model.dart';

class WordTypeAdapter extends TypeAdapter<WordModel> {
  @override
  WordModel read(BinaryReader reader) {
    return WordModel(
        indexWord: reader.readInt(),
        colorCode: reader.readInt(),
        isArabic: reader.readBool(),
        text: reader.readString(),
        arabicExamples: reader.readStringList(),
        arabicSimilarWords: reader.readStringList(),
        englishExamples: reader.readStringList(),
        englishSimilarWords: reader.readStringList());
  }

  @override

  int get typeId => 0;

  @override
  void write(BinaryWriter writer, WordModel obj) {
  writer.write(obj.indexWord);
  writer.write(obj.text);
    writer.write(obj.englishSimilarWords);
    writer.write(obj.arabicSimilarWords);
    writer.write(obj.isArabic);
    writer.write(obj.arabicExamples);
    writer.write(obj.englishExamples);
  writer.write(obj.colorCode);


  }
}
