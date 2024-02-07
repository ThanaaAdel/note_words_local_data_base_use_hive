import 'package:flutter/material.dart';
import 'package:note_words_local_data_base_use_hive/view/styles/color_manager.dart';
class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.colorButton, required this.callFunction});
final int colorButton;
final VoidCallback callFunction;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callFunction,
      child: Container(height: 48,
      width: 80,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),color: ColorsManager.whiteColor,),
      child: Center(child: Text("Done",style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Color(colorButton)))),
      ),
    );
  }
}
