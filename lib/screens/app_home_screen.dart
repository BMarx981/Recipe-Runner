import 'package:flutter/material.dart';
import 'package:recipe_writer/utils/colors.dart';
import 'package:recipe_writer/screens/main_screen_tile.dart';

class AppHomeScreen extends StatelessWidget {
  final String title;
  final List<MainScreenTile> list = [
    MainScreenTile(),
    MainScreenTile(),
    MainScreenTile(),
  ];
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
          child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return list[index];
        },
      )),
    );
  }
}
