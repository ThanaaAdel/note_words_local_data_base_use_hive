import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_words_local_data_base_use_hive/view/widgets/text_form_field.dart';
import '../../controller/read_data_cubit/read_data_cubit.dart';
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
      child: BlocConsumer<WriteDataCubit,WriteDataCubitStates>
        (
       listener: (context,state){
         if(state is WriteDataCubitSuccessState){
           Navigator.pop(context);
         }
         else if(state is WriteDataCubitFailedState){
            ScaffoldMessenger.of(context).showSnackBar(buildSnackBar(state));
         }
       },
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
                          callFunction: ()async{
                            if(formField.currentState!.validate()){
                              WriteDataCubit.get(context).addWord();
                              ReadDataCubit.get(context).getWords();
                            }},
                          colorButton:WriteDataCubit.get(context).colorCode )),
                ],
              ),
            ),
          ),)
    );
  }

  SnackBar buildSnackBar(WriteDataCubitFailedState state) => SnackBar(content: Text(state.messageError));
}
