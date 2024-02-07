import 'package:flutter/material.dart';
import 'package:note_words_local_data_base_use_hive/controller/write_data_cubit/write_data_cubit.dart';
import 'package:note_words_local_data_base_use_hive/view/styles/color_manager.dart';

class ColorWidget extends StatelessWidget {
  const ColorWidget({super.key, required this.activeColorCode});
  final int activeColorCode;
  final List<int> _colorCodes = const [
    0XFF4A47A3,
    0XFF0C7B93,
    0xFF892CDC,
    0XFFBC6FF1,
    0xFFF4ABC4,
    0XFFC70039,
    0xFF8FBC8F,
    0xFFFA8072,
    0XFF4D4C7D,
  ];
  Widget getItemDesign(int index,BuildContext context) {
    return GestureDetector(
      onTap: () =>  WriteDataCubit.get(context).updateColorCode(_colorCodes[index]),
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: activeColorCode == _colorCodes[index]
                ? Border.all(color: ColorsManager.whiteColor, width: 2)
                : null,
            color: Color(_colorCodes[index])),
        child: activeColorCode == _colorCodes[index]
            ? const Center(
                child: Icon(
                  Icons.done,
                  size: 26,
                  color: ColorsManager.whiteColor,
                ),
              )
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(
          width: 7,
        ),
        itemBuilder: (context, index) => getItemDesign(index,context),
        itemCount: _colorCodes.length,
        physics: const BouncingScrollPhysics(),
      ),
    );
  }
}
