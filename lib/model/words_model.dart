class WordModel {
  final int indexWord;
  final int colorCode;
  final String text;
  final bool isArabic;
  final List<String> arabicSimilarWords;
  final List<String> englishSimilarWords;
  final List<String> arabicExamples;
  final List<String> englishExamples;
  WordModel({
    required this.indexWord,
    required this.colorCode,
    required this.isArabic,
    required this.text,
    this.arabicExamples = const [],
    this.arabicSimilarWords = const [],
    this.englishExamples = const [],
    this.englishSimilarWords = const [],
  });
  WordModel decrementIndexInDataBase() {
    return WordModel(
        indexWord: indexWord - 1,
        colorCode: colorCode,
        isArabic: isArabic,
        text: text,
        englishSimilarWords: englishSimilarWords,
        arabicSimilarWords: arabicSimilarWords,
        arabicExamples: arabicExamples,
        englishExamples: englishExamples);
  }

  WordModel addNewExample(String newExample, bool isArabicExample) {
    List<String> newExamplesWord = _intializeNewExamples(isArabicExample);
    newExamplesWord.add(newExample);
    return _getWordAfterCheckExamples(isArabicExample, newExamplesWord);
  }

  WordModel addSimilarWord(String similarWord, bool isArabicSimilarWord) {
    List<String> newSimilarWords = _intializeNewSimilarWords(isArabicSimilarWord);
    newSimilarWords.add(similarWord);
    return _getWordAfterCheckSimilarWord(isArabicSimilarWord, newSimilarWords);
  }

  WordModel deleteSimilarWord(int indexSimilarWord, bool isArabicSimilarWord) {
    List<String> newSimilarWords =
    _intializeNewSimilarWords(isArabicSimilarWord);
    newSimilarWords.removeAt(indexSimilarWord);
    return _getWordAfterCheckSimilarWord(isArabicSimilarWord, newSimilarWords);
  }

  WordModel deleteExampleWord(int indexExampleWord, bool isArabicExample) {
    List<String> newExamplesWord = _intializeNewExamples(isArabicExample);
    newExamplesWord.removeAt(indexExampleWord);
    return _getWordAfterCheckExamples(isArabicExample, newExamplesWord);
  }

  WordModel _getWordAfterCheckSimilarWord(
      bool isArabicSimilarWord, List<String> newSimilarWords) {
    return WordModel(
      indexWord: indexWord,
      colorCode: colorCode,
      isArabic: isArabic,
      text: text,
      englishExamples: englishExamples,
      arabicExamples: arabicExamples,
      arabicSimilarWords:
          isArabicSimilarWord ? newSimilarWords : arabicSimilarWords,
      englishSimilarWords:
          !isArabicSimilarWord ? newSimilarWords : englishSimilarWords,
    );
  }

  WordModel _getWordAfterCheckExamples(
      bool isArabicExample, List<String> newExamplesWord) {
    return WordModel(
      indexWord: indexWord,
      colorCode: colorCode,
      isArabic: isArabic,
      text: text,
      englishExamples: !isArabicExample ? newExamplesWord : englishExamples,
      arabicExamples: isArabicExample ? newExamplesWord : arabicExamples,
      arabicSimilarWords: arabicSimilarWords,
      englishSimilarWords: englishSimilarWords,
    );
  }

  List<String>_intializeNewExamples(bool isArabicExample){
    if(isArabicExample){
      return List.from(arabicExamples);
    }
    return List.from(englishExamples);
  }
  List<String> _intializeNewSimilarWords(bool isArabicSimilarWord) {
    if (isArabicSimilarWord) {
      return List.from(arabicSimilarWords);
    } else {
      return List.from(englishSimilarWords);
    }
  }}