import 'package:flutter/material.dart';
import 'package:note_words_local_data_base_use_hive/controller/write_data_cubit/write_data_cubit.dart';
import 'package:note_words_local_data_base_use_hive/view/styles/color_manager.dart';

class TextFormFieldWidget extends StatefulWidget {
  const TextFormFieldWidget(
      {super.key, required this.globalKey, required this.text});
  final GlobalKey<FormState> globalKey;
  final String text;

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.globalKey,
        child: TextFormField(
          autofocus: true,
          maxLines: 2,
          minLines: 1,
          controller: textEditingController,
          cursorColor: ColorsManager.whiteColor,
          style: const TextStyle(color: ColorsManager.whiteColor),
          decoration: decorationFromTextField(),
          onChanged: (value) => WriteDataCubit().updateText(widget.text),
          validator: (value) {
          return  _validator(
              value!,
              WriteDataCubit.get(context).isArabic,
            );
          },
        ));
  }

  String? _validator(String value, bool isArabic) {
    if (value == null || value.trim().isEmpty) {
      return "This field must not be empty";
    }

    for (int i = 0; i < value.length; i++) {
      CharacterType characterType = _getCharacterType(value.codeUnitAt(i));
      if (characterType == CharacterType.notValid) {
        return "Char Number ${i + 1} is not valid";
      } else if (characterType == CharacterType.arabic && !isArabic) {
        return "Char Number ${i + 1} is not an English Char";
      } else if (characterType == CharacterType.english && isArabic) {
        return "Char Number ${i + 1} is not an Arabic Char";
      }
    }

    return null; // Return null if no errors are found
  }


  CharacterType _getCharacterType(int asciiCode) {
    if ((asciiCode >= 65 && asciiCode <= 90) ||
        (asciiCode >= 97 && asciiCode <= 122)) {
      return CharacterType.english;
    }
    if ((asciiCode >= 1536 && asciiCode <= 1791) || // Arabic script range
        (asciiCode == 32)) { // Allow space for both Arabic and English
      return CharacterType.arabic;
    }
    return CharacterType.notValid;
  }


  InputDecoration decorationFromTextField() {
    return InputDecoration(
      labelStyle: const TextStyle(color: ColorsManager.whiteColor),
      labelText: widget.text,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: ColorsManager.whiteColor,
          width: 2,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: ColorsManager.whiteColor,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: ColorsManager.redColor,
          width: 2,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: ColorsManager.redColor,
          width: 2,
        ),
      ),
    );
  }
}
enum CharacterType{
 arabic,
 english,
 space,
 notValid,
}