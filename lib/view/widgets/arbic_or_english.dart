import 'package:flutter/material.dart';
import 'package:note_words_local_data_base_use_hive/view/styles/color_manager.dart';
import '../../controller/write_data_cubit/write_data_cubit.dart';

class ArabicOrEnglishWidget extends StatelessWidget {
  const ArabicOrEnglishWidget(
      {super.key, required this.colorCode, required this.arabicIsSelected});
  final int colorCode;
  final bool arabicIsSelected;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _getContainerDialog(true,context),
        const SizedBox(width: 5,),
        _getContainerDialog(false,context),
      ],
    );
  }

  GestureDetector _getContainerDialog(bool buildIsArabic,BuildContext context) {
    return GestureDetector(
      onTap: () => WriteDataCubit.get(context).updateIsArabic(buildIsArabic),
      child: Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            color: buildIsArabic == arabicIsSelected ? ColorsManager.whiteColor : Color(colorCode),
              shape: BoxShape.circle,
              border: Border.all(width: 2, color: ColorsManager.whiteColor)),
          child: Center(
              child: Text(
                buildIsArabic ? "ar" :"en",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21,
            color:!(buildIsArabic == arabicIsSelected) ? ColorsManager.whiteColor : Color(colorCode)
            ),
          )),
        ),
    );
  }
}
