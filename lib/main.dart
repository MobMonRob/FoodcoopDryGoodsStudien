import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:studienarbeit/main_page.dart';
import 'package:studienarbeit/models/CartModel.dart';
import 'package:studienarbeit/models/DataModel.dart';
import 'package:studienarbeit/utils.dart';

Future<void> main() async {
  runApp(
    MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => DataModel()),
          ChangeNotifierProvider(create: (_) => CartModel()),
        ],
      child: FoodcoopApp(),
    )
  );
}

class FoodcoopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodcoop',
      theme: customTheme,
      home: MainPage(),
    );
  }
}