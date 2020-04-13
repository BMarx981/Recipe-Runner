import 'package:flutter/material.dart';
import 'package:recipe_writer/utils/colors.dart';

class AppHomeScreen extends StatelessWidget {
  final String title;
  AppHomeScreen(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        elevation: .9,
        color: mainTheme,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              Icons.list,
              color: Colors.white,
            ),
            Icon(
              Icons.add,
              color: Colors.white,
            ),
          ],
        ),
      ),
      appBar: AppBar(
        toolbarOpacity: 0.61,
        flexibleSpace: Container(
          height: 100,
          width: 200,
          decoration: BoxDecoration(gradient: colorGrad),
        ),
        backgroundColor: mainTheme,
        title: Text(title),
      ),
      body: Center(
        child: Text('Welcome to the Home Screen'),
      ),
    );
  }
}
