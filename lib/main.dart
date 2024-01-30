import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:note_words_local_data_base_use_hive/hive_constants/hive_constants.dart';
import 'package:note_words_local_data_base_use_hive/model/word_type_adaptar.dart';

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
    return const MaterialApp(
     debugShowCheckedModeBanner: false,

    );
  }
}


