import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_project/data_model/student_model.dart';
import 'package:getx_project/screens/homescreen.dart';

import 'package:hive_flutter/hive_flutter.dart';



void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(StudentAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey[200]!),
        useMaterial3: true,
      ),
      home:  HomeScreen(),
    );
  }
}

