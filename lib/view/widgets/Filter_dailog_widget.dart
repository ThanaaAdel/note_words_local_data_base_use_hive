import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_words_local_data_base_use_hive/controller/read_data_cubit/read_data_cubit.dart';
import 'package:note_words_local_data_base_use_hive/controller/read_data_cubit/read_data_cubit_states.dart';
import 'package:note_words_local_data_base_use_hive/view/styles/color_manager.dart';

class FilterDialogWidget extends StatelessWidget {
  const FilterDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit,ReadDataCubitStates>(builder: (context, state) {
      return Dialog(
        backgroundColor: ColorsManager.blackColor,
        child: Padding(
          padding: const EdgeInsets.all(10),

          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _getLabelText("Language"),
              const SizedBox(height: 10,),
              _getLanguageFilter(context),
              const SizedBox(height: 15,),
              _getLabelText("Sorted By"),
              const SizedBox(height: 10,),
              _getSortingByFilter(context),
              const SizedBox(height: 15,),
              _getLabelText("Sorted Type"),
              const SizedBox(height: 10,),
              _getSortingTypeFilter(context),

            ],
          ),
        ),
      );
    },);
  }

  Widget _getSortingTypeFilter(BuildContext context) {
    return _getFilterField(labels: ["Ascending", "Descending"], conditionsOfActivations: [
              ReadDataCubit.get(context).sortingType ==
                  SortingType.ascending,
              ReadDataCubit.get(context).sortingType ==
                  SortingType.descending,

            ], onTap: [
                  () => ReadDataCubit.get(context)
                  .updateSortedType(SortingType.ascending),
                  () => ReadDataCubit.get(context)
                  .updateSortedType(SortingType.descending),

            ],);
  }

  Widget _getSortingByFilter(BuildContext context) {
    return _getFilterField(labels: ["Time", "Word Length"], conditionsOfActivations: [
              ReadDataCubit.get(context).sortingBy ==
                  SortingBy.time,
              ReadDataCubit.get(context).sortingBy ==
                  SortingBy.wordLength,

            ], onTap: [
                  () => ReadDataCubit.get(context)
                  .updateSortingBy(SortingBy.time),
                  () => ReadDataCubit.get(context)
                  .updateSortingBy(SortingBy.wordLength),

            ],);
  }

  Widget _getLanguageFilter(BuildContext context) {
    return _getFilterField(labels: ["Arabic", "English", "All"], conditionsOfActivations: [
                ReadDataCubit.get(context).languageFilter ==
                    LanguageFilter.arabicOnly,
                ReadDataCubit.get(context).languageFilter ==
                    LanguageFilter.englishOnly,
                ReadDataCubit.get(context).languageFilter ==
                    LanguageFilter.allWords,
              ], onTap: [
                    () => ReadDataCubit.get(context)
                    .updateLanguageFilter(LanguageFilter.arabicOnly),
                    () => ReadDataCubit.get(context)
                    .updateLanguageFilter(LanguageFilter.englishOnly),
                    () => ReadDataCubit.get(context)
                    .updateLanguageFilter(LanguageFilter.allWords),
              ],);
  }

  Widget _getFilterField(
      {required List<String> labels,
      required List<VoidCallback> onTap,
      required List<bool> conditionsOfActivations}) {
    return Row(
      children: [
        for (int i = 0; i < labels.length; i++)
          InkWell(
            onTap: onTap[i],
            child: Container(
              height: 50,
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  color: conditionsOfActivations[i]
                      ? ColorsManager.whiteColor
                      : ColorsManager.blackColor,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    width: 2,
                    color: ColorsManager.whiteColor,
                  )),
              child: Center(
                  child: Text(
                labels[i],
                style: TextStyle(
                    fontSize: 18,
                    color: conditionsOfActivations[i]
                        ? ColorsManager.blackColor
                        : ColorsManager.whiteColor),
              )),
            ),
          )
      ],
    );
  }

  Widget _getLabelText(String labelText) {
    return Text(
      labelText,
      style: const TextStyle(fontSize: 21, color: ColorsManager.whiteColor),
    );
  }
}
