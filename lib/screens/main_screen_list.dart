import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_writer/models/main_model.dart';
import 'package:recipe_writer/models/recipe.dart';
import 'package:recipe_writer/screens/recipe_screen.dart';
import 'package:recipe_writer/utils/db_helper.dart';

import 'main_screen_tile.dart';

class MainScreenList extends StatefulWidget {
  @override
  _MainScreenListState createState() => _MainScreenListState();
}

class _MainScreenListState extends State<MainScreenList> {
  DatabaseHelper dbh = DatabaseHelper.instance;
  final List<Recipe> mainList = [];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MainModel>(context, listen: false);
    return Scrollbar(
      child: ListView.builder(
        itemCount: Provider.of<MainModel>(context).recipes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return RecipeScreen(
                      provider.recipes[index],
                    );
                  },
                ),
              ).then((value) => setState(() {}));
            },
            child: Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                setState(() {
                  dbh.delete(provider.recipes[index].id);
                  provider.recipes.removeAt(index);
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: MainScreenTile(
                  provider.recipes[index],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
