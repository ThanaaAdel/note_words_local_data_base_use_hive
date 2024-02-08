import 'package:flutter/material.dart';
import 'package:note_words_local_data_base_use_hive/view/styles/color_manager.dart';
class FilterDialogWidget extends StatelessWidget {
  const FilterDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorsManager.blackColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
        _getLabelText("Language"),
        _getLabelText("Sorted By"),
        _getLabelText("Sorted Type"),
      ],),
    );
  }
  Widget _getLabelText(String labelText){
    return Text(labelText,style: const TextStyle(
        fontSize: 21,
        color: ColorsManager.whiteColor),);
  }
}
