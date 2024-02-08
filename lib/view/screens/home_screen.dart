import 'package:flutter/material.dart';
import 'package:note_words_local_data_base_use_hive/view/styles/color_manager.dart';
import 'package:note_words_local_data_base_use_hive/view/widgets/show_dialog_widget.dart';
import '../widgets/filter_dailog_button.dart';
import '../widgets/language_filter_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) => const ShowDialogWidget());
        },
        backgroundColor: ColorsManager.whiteColor,
        child: const Icon(
          Icons.add,
          color: ColorsManager.blackColor,
          size: 30,
        ),
      ),
      appBar: AppBar(title: const Text("Home")),
      body:   const Padding(
        padding: EdgeInsets.all(15),
        child: Row(children: [
          LanguageFilterWidget(),
          Spacer(),
          FilterDialogButton(),
        ]),
      ),
    );
  }
}
