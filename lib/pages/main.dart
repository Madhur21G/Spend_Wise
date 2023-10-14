import 'package:flutter/material.dart';
import 'package:spend_wise/data/expense_data.dart';
import 'home_page.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{

  //initialize hive
  await Hive.initFlutter();

  //open a hive box
  await Hive.openBox("expense_database2");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return ChangeNotifierProvider(
        create: (context) => ExpenseData(),
        builder : (context, child) => const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        ),
    );
  }
}