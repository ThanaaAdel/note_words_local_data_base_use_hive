import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_words_local_data_base_use_hive/controller/read_data_cubit/read_data_cubit.dart';
import 'package:note_words_local_data_base_use_hive/controller/read_data_cubit/read_data_cubit_states.dart';
import 'package:note_words_local_data_base_use_hive/view/styles/color_manager.dart';
import 'package:note_words_local_data_base_use_hive/view/widgets/word_item_widget.dart';
import '../../model/words_model.dart';
import 'exception_widget.dart';
class WordsWidget extends StatelessWidget {
  const WordsWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataCubitStates>(
      builder: (context, state) {
        if (state is ReadDataCubitSuccessState) {
          if (state.words.isEmpty) {
            return _getEmptyWordsWidget();
          }
          return _getWordsWidget(state.words);
        } else if (state is ReadDataCubitFailedState) {
          return _getFailedWidget(state.messageError);
        } else {
          return _getLoadingWidget();
        }
      },
    );
  }

  Widget _getWordsWidget(List<WordModel> words) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          itemCount: words.length,
          itemBuilder: (context, index) {
            return WordItemWidget(
              words: words[index],
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 2 / 1.5,
              crossAxisCount: 2)),
    );
  }

  Widget _getEmptyWordsWidget() {
    return const ExceptionWidget(
      text: "This List is Empty",
      iconData: Icons.list,
    );
  }

  Widget _getFailedWidget(String message) {
    return ExceptionWidget(
      text: message,
      iconData: Icons.error,
    );
  }

  Widget _getLoadingWidget() {
    return const Center(
      child: CircularProgressIndicator(
        color: ColorsManager.whiteColor,
      ),
    );
  }
}
