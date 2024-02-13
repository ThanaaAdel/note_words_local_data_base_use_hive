import 'package:flutter/material.dart';
import 'package:note_words_local_data_base_use_hive/controller/read_data_cubit/read_data_cubit.dart';
import 'package:note_words_local_data_base_use_hive/model/words_model.dart';
import 'package:note_words_local_data_base_use_hive/view/screens/details_screen.dart';
import 'package:note_words_local_data_base_use_hive/view/styles/color_manager.dart';

class WordItemWidget extends StatelessWidget {
  const WordItemWidget({super.key, required this.words});
  final WordModel words;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => WordDetailsScreen(
                          words: words,
                        )))
            .then((value) async => Future.delayed(const Duration(microseconds: 20)))
            .then((value) => ReadDataCubit.get(context).getWords());
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            color: Color(words.colorCode)),
        child: Center(
            child: Text(words.text,
                style: const TextStyle(
                    fontSize: 25, color: ColorsManager.whiteColor))),
      ),
    );
  }
}
