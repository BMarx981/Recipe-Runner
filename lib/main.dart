import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/main_model.dart';
import 'screens/app_home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainModel(),
      child: MaterialApp(
        home: AppHomeScreen(),
      ),
    );
  }
}
