import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_words_local_data_base_use_hive/controller/read_data_cubit/read_data_cubit.dart';
import 'package:note_words_local_data_base_use_hive/controller/write_data_cubit/write_data_cubit.dart';
import 'package:note_words_local_data_base_use_hive/controller/write_data_cubit/write_data_cubit_states.dart';
import 'package:note_words_local_data_base_use_hive/view/styles/color_manager.dart';
import 'package:note_words_local_data_base_use_hive/view/widgets/arbic_or_english.dart';
import 'package:note_words_local_data_base_use_hive/view/widgets/button_widget.dart';
import 'package:note_words_local_data_base_use_hive/view/widgets/text_form_field.dart';
class UploadDialog extends StatefulWidget {
  const UploadDialog({super.key, required this.colorCode, required this.isExample, required this.indexInDatabase});
  final int colorCode;
  final bool isExample;
  final int indexInDatabase;
  @override
  State<UploadDialog> createState() => _UploadDialogState();
}

class _UploadDialogState extends State<UploadDialog> {
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WriteDataCubit,WriteDataCubitStates>(
      listener: (context, state) {
        if(state is WriteDataCubitSuccessState){
          Navigator.pop(context);
        }
        else if(state is WriteDataCubitFailedState){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.messageError,style: const TextStyle(color: ColorsManager.redColor),)));
        }
      },
      builder: (context, state) {
        return  Dialog(
          backgroundColor: Color(widget.colorCode),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
              ArabicOrEnglishWidget(colorCode: widget.colorCode, arabicIsSelected: WriteDataCubit.get(context).isArabic),
                  const SizedBox(height: 20,),
                  TextFormFieldWidget(globalKey: globalKey, text: widget.isExample ? "New Example" : "New SimilarWord"),
                  const SizedBox(height: 20,),
                  Align(
                      alignment: Alignment.topRight,
                      child: ButtonWidget(colorButton: widget.colorCode, callFunction: (){

                        if(globalKey.currentState!.validate()){
                          if(widget.isExample){
                            WriteDataCubit.get(context).addExample(widget.indexInDatabase);
                          }
                          else{
                            WriteDataCubit.get(context).addSimilarWord(widget.indexInDatabase);
                          }
                          ReadDataCubit.get(context).getWords();
                        }

                      }))
            ]),
          ),
        );
      },

    );
  }
}
