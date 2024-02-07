import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:note_words_local_data_base_use_hive/view/styles/color_manager.dart';

abstract class ThemeManager{
  static ThemeData getAppTheme(){
    return ThemeData(
      scaffoldBackgroundColor: ColorsManager.blackColor,
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: ColorsManager.blackColor,
        centerTitle: true,
        titleTextStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 21),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorsManager.blackColor,
        ),
      )
    );
  }
}