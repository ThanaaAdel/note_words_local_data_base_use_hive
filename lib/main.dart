import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_words_local_data_base_use_hive/controller/read_data_cubilt/read_data_cubit.dart';
import 'package:note_words_local_data_base_use_hive/hive_constants/hive_constants.dart';
import 'package:note_words_local_data_base_use_hive/model/word_type_adaptar.dart';
import 'package:note_words_local_data_base_use_hive/view/screens/home_screen.dart';
import 'package:note_words_local_data_base_use_hive/view/styles/theme_manager.dart';

import 'controller/write_data_cubit/write_data_cubit.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WordTypeAdapter());
  Hive.openBox(HiveConstants.hiveBoxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(providers: [
      BlocProvider(create: (context) => ReadDataCubit(),),
    BlocProvider(create: (context) => WriteDataCubit()),
    ], child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.getAppTheme(),
      home: const HomeScreen(),
    ));
  }
}


