import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_words_local_data_base_use_hive/controller/read_data_cubilt/read_data_cubit.dart';
import 'package:note_words_local_data_base_use_hive/view/widgets/text_form_field.dart';
import '../../controller/write_data_cubit/write_data_cubit.dart';
import '../../controller/write_data_cubit/write_data_cubit_states.dart';
import 'arbic_or_english.dart';
import 'button_widget.dart';
import 'color_widget.dart';

class ShowDialogWidget extends StatefulWidget {
  const ShowDialogWidget({super.key});

  @override
  State<ShowDialogWidget> createState() => _ShowDialogWidgetState();
}

class _ShowDialogWidgetState extends State<ShowDialogWidget> {
final GlobalKey<FormState> formField = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocBuilder<WriteDataCubit, WriteDataCubitStates>(
        builder: (context, state) => AnimatedContainer(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          duration: const Duration(milliseconds: 750),
          color: Color(WriteDataCubit.get(context).colorCode),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ArabicOrEnglishWidget( colorCode: WriteDataCubit.get(context).colorCode,
                arabicIsSelected: WriteDataCubit.get(context).isArabic,
                ),
                const SizedBox(height: 15,),
                ColorWidget(activeColorCode: WriteDataCubit.get(context).colorCode),
                const SizedBox(height: 15,),
                TextFormFieldWidget(globalKey: formField,text: "New Word"),
                const SizedBox(height: 15,),
                Align(
                    alignment: Alignment.topRight,
                    child: ButtonWidget(
                        callFunction: (){
                          if(formField.currentState!.validate()){
                            WriteDataCubit.get(context).addNewWord();
                            ReadDataCubit.get(context).getWords();
                          }},
                        colorButton:WriteDataCubit.get(context).colorCode )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
