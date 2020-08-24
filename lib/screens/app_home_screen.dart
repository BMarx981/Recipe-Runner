import 'package:flutter/material.dart';
import 'package:recipe_writer/screens/add_item_screen.dart';
import 'package:recipe_writer/screens/planner_screen.dart';
import 'package:recipe_writer/screens/search_screen.dart';
import 'package:recipe_writer/utils/colors.dart';

import 'main_screen_list.dart';
import 'settings_screen.dart';

class AppHomeScreen extends StatefulWidget {
  @override
  _AppHomeScreenState createState() => _AppHomeScreenState();
}

class _AppHomeScreenState extends State<AppHomeScreen> {
  int _selectedScreenIndex = 0;

  String title = 'Cobo';

  void _selectScreen(int index) {
    setState(
      () {
        _selectedScreenIndex = index;
        if (_selectedScreenIndex == 0) {
          title = 'Cobo';
        } else if (_selectedScreenIndex == 1) {
          title = 'Search recipes';
        } else if (_selectedScreenIndex == 2) {
<<<<<<< HEAD
          title = 'Add a recipe';
=======
          title = 'Add a Recipe';
        } else if (_selectedScreenIndex == 3) {
          title = 'Planner';
>>>>>>> dev
        }
      },
    );
  }

  List<Widget> _screenList = <Widget>[
    MainScreenList(),
    SearchScreen(),
    AddItemScreen(),
    PlannerScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedScreenIndex,
          elevation: .9,
          backgroundColor: mainTheme,
          selectedItemColor: blue,
          unselectedItemColor: white,
          type: BottomNavigationBarType.fixed,
          onTap: (index) => _selectScreen(index),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.list,
              ),
              title: Text(
                'List',
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              title: Text(
                'Search',
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
              ),
              title: Text(
                'Add',
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.calendar_today,
              ),
              title: Text(
                'Planner',
              ),
            ),
          ],
        ),
        appBar: AppBar(
          centerTitle: false,
          elevation: 0.0,
          backgroundColor: red,
          title: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 34,
            ),
          ),
<<<<<<< HEAD
        ],
        onTap: (index) => _selectScreen(index),
      ),
      appBar: AppBar(
        centerTitle: false,
        elevation: 0.0,
        backgroundColor: red,
        title: Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Text(title),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.settings, color: white),
            onPressed: () {
              openSettings(context);
            },
=======
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.settings, color: white),
              onPressed: () {
                openSettings(context);
              },
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(gradient: colorGrad),
          child: Padding(
            padding: const EdgeInsets.only(left: 18, right: 18, top: 8),
            child: _screenList[_selectedScreenIndex],
>>>>>>> dev
          ),
        ),
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
