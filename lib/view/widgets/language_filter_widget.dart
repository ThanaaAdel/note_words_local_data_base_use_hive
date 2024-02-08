import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_words_local_data_base_use_hive/view/styles/color_manager.dart';
import '../../controller/read_data_cubit/read_data_cubit.dart';
import '../../controller/read_data_cubit/read_data_cubit_states.dart';

class LanguageFilterWidget extends StatelessWidget {
  const LanguageFilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataCubitStates>(
      builder: (context, state) {
        return Text(_mapLanguageFilterEnumToString(
            ReadDataCubit.get(context).languageFilter),
        style: const TextStyle(color: ColorsManager.whiteColor,fontSize: 21),
        );
      },
    );
  }
}

String _mapLanguageFilterEnumToString(LanguageFilter languageFilter) {
  if (languageFilter == LanguageFilter.allWords) {
    return "All Words";
  } else if (languageFilter == LanguageFilter.englishOnly) {
    return "English Only";
  } else {
    return "Arabic Only";
  }
}
