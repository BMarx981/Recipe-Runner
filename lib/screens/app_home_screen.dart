import 'package:flutter/material.dart';
import 'package:recipe_writer/screens/add_item_screen.dart';
import 'package:recipe_writer/utils/colors.dart';
import 'package:recipe_writer/screens/main_screen_tile.dart';
import 'main_screen_list.dart';

class AppHomeScreen extends StatefulWidget {
  final String title;

  AppHomeScreen(this.title);

  @override
  _AppHomeScreenState createState() => _AppHomeScreenState();
}

class _AppHomeScreenState extends State<AppHomeScreen> {
  int _selectedScreenIndex = 0;
  static final List<MainScreenTile> list = [
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
  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });

    print(_selectedScreenIndex);
  }

  List<Widget> _screenList = <Widget>[
    MainScreenList(list: list),
    AddItemScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreenIndex,
        elevation: .9,
        backgroundColor: mainTheme,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.list,
              color: white,
            ),
            title: Text(
              'List',
              style: TextStyle(
                  color: (_selectedScreenIndex == 1) ? white : Colors.blue),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              color: white,
            ),
            title: Text(
              'Add',
              style: TextStyle(
                  color: (_selectedScreenIndex == 0) ? white : Colors.blue),
            ),
          ),
        ],
        onTap: (index) => _selectScreen(index),
      ),
      appBar: AppBar(
        flexibleSpace: Container(
          height: 100,
          width: 200,
          decoration: BoxDecoration(gradient: colorGrad),
        ),
        backgroundColor: mainTheme,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 8),
        child: _screenList[_selectedScreenIndex],
      ),
    );
  }
}
