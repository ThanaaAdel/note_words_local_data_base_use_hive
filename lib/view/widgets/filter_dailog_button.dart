import 'package:flutter/material.dart';
import 'package:note_words_local_data_base_use_hive/view/styles/color_manager.dart';
import 'package:note_words_local_data_base_use_hive/view/widgets/Filter_dailog_widget.dart';
class FilterDialogButton extends StatelessWidget {
  const FilterDialogButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () {
    showDialog(context: context, builder: (context) => const FilterDialogWidget(),);
    },
    child: const CircleAvatar(
      backgroundColor: ColorsManager.whiteColor,
      child:
    Icon(Icons.filter_list,color: ColorsManager.blackColor,),
    ),);
  }
}
