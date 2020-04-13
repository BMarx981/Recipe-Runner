import 'package:flutter/material.dart';
import 'screens/app_home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppHomeScreen('Recipe Runner'),
    );
  }
}
