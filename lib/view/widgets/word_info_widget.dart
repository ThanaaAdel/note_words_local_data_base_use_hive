import 'package:flutter/material.dart';
import 'package:note_words_local_data_base_use_hive/view/styles/color_manager.dart';

class WordInfoWidget extends StatelessWidget {
  const WordInfoWidget(
      {super.key,
      required this.color,
      required this.text,
      required this.isArabic,
      this.onPressed});
  final Color color;
  final String text;
  final bool isArabic;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(children: [
        _getIsArabicText(),
        const SizedBox(
          width: 20,
        ),
        _getTextWord(),
        if(onPressed!=null)
          const Icon(
              Icons.delete,
              size: 35,
              color: ColorsManager.blackColor),

      ]),
    );
  }

  Expanded _getTextWord() {
    return Expanded(
        child: Text(
      text,
      style: const TextStyle(
        color: ColorsManager.blackColor,
        fontWeight: FontWeight.bold,
        fontSize: 23,
      ),
    ));
  }

  CircleAvatar _getIsArabicText() {
    return CircleAvatar(
      backgroundColor: ColorsManager.blackColor,
      radius: 30,
      child: Text(
        isArabic?"ar":"en",
        style: TextStyle(
          color: color,
          fontSize: 21
        ),
      ),
    );
  }
}
