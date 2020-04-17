import 'package:flutter/material.dart';
import 'package:recipe_writer/screens/add_item_screen.dart';
import 'package:recipe_writer/utils/colors.dart';

import 'main_screen_list.dart';
import 'settings_screen.dart';

class AppHomeScreen extends StatefulWidget {
  @override
  _AppHomeScreenState createState() => _AppHomeScreenState();
}

class _AppHomeScreenState extends State<AppHomeScreen> {
  int _selectedScreenIndex = 0;
  String title = 'Recipe Runner';
  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
      if (_selectedScreenIndex == 0) {
        title = 'Recipe Runner';
      } else if (_selectedScreenIndex == 1) {
        title = 'Add a Recipe';
      }
    });
  }

  List<Widget> _screenList = <Widget>[
    //TODO: Add title to each of these constructors
    MainScreenList(),
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
            backgroundColor: (_selectedScreenIndex == 1) ? blue : white,
            icon: Icon(
              Icons.list,
              color: (_selectedScreenIndex == 1) ? white : blue,
            ),
            title: Text(
              'List',
              style:
                  TextStyle(color: (_selectedScreenIndex == 1) ? white : blue),
            ),
          ),
          BottomNavigationBarItem(
            backgroundColor: (_selectedScreenIndex == 0) ? blue : white,
            icon: Icon(
              Icons.add,
              color: (_selectedScreenIndex == 0) ? white : blue,
            ),
            title: Text(
              'Add',
              style:
                  TextStyle(color: (_selectedScreenIndex == 0) ? white : blue),
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
//        backgroundColor: mainTheme,
        title: Text(title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings, color: white),
            onPressed: () {
              openSettings(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 18, right: 18, top: 8),
        child: _screenList[_selectedScreenIndex],
      ),
    );
  }

  void openSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return SettingsScreen(context: context);
        },
      ),
    );
  }
}
