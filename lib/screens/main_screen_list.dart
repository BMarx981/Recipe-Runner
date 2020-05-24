import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_writer/models/main_model.dart';
import 'package:recipe_writer/screens/recipe_screen.dart';

import 'main_screen_tile.dart';

class MainScreenList extends StatefulWidget {
  @override
  _MainScreenListState createState() => _MainScreenListState();
}

class _MainScreenListState extends State<MainScreenList> {
  MainModel mm = MainModel();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: mm.populateRecipes(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
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
                            Provider.of<MainModel>(context, listen: false)
                                .recipes[index],
                          );
                        },
                      ),
                    ).then((value) => setState(() {}));
                  },
                  child: Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      setState(() {
                        Provider.of<MainModel>(context, listen: false)
                            .recipes
                            .removeAt(index);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: MainScreenTile(
                        Provider.of<MainModel>(context, listen: false)
                            .recipes[index],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        });
  }
}
