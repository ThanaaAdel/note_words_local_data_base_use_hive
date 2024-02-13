import 'package:flutter/material.dart';
import 'package:note_words_local_data_base_use_hive/view/styles/color_manager.dart';

class ExceptionWidget extends StatelessWidget {
  const ExceptionWidget(
      {super.key, required this.iconData, required this.text});
  final IconData iconData;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            iconData,
            color: ColorsManager.whiteColor,
            size: 60,
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            text,
            style: const TextStyle(fontSize: 24, color: ColorsManager.whiteColor),
          )
        ],
      ),
    );
  }
}
