import 'package:flutter/material.dart';
import 'package:recipe_writer/utils/colors.dart';
import 'package:recipe_writer/screens/main_screen_tile.dart';
import 'main_screen_list.dart';

class AppHomeScreen extends StatelessWidget {
  final String title;
  final List<MainScreenTile> list = [
    MainScreenTile(
      'Recipe Title',
      'This is a description of the recipe to help you understand what you are looking at.',
      '🍔',
    ),
    MainScreenTile(
      'Recipe Title',
      'This is a description of the recipe to help you understand what you are looking at.',
      '🍔',
    ),
    MainScreenTile(
      'Recipe Title',
      'This is a description of the recipe to help you understand what you are looking at.',
      '🍔',
    ),
  ];
  AppHomeScreen(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      bottomNavigationBar: BottomAppBar(
        elevation: .9,
        color: mainTheme,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                print('List icon selected');
              },
              child: Icon(
                Icons.list,
                color: Colors.white,
              ),
            ),
            GestureDetector(
              onTap: () {
                print('Add icon selected');
              },
              child: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        flexibleSpace: Container(
          height: 100,
          width: 200,
          decoration: BoxDecoration(gradient: colorGrad),
        ),
        backgroundColor: mainTheme,
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 8),
        child: MainScreenList(list: list),
      ),
    );
  }
}
