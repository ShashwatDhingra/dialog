import 'package:dialog/dialog1.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
import 'grid_background/grid_background.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Flutter Demo', home: HomePage());
  }
}
