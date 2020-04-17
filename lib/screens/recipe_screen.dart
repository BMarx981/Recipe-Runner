import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_writer/models/recipe.dart';
import 'package:recipe_writer/utils/colors.dart';
import 'edit_recipe_screen.dart';

class RecipeScreen extends StatelessWidget {
  final Recipe recipe;
  RecipeScreen(this.recipe);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: colors,
            stops: [0.5, 0.9],
          ),
        ),
        child: Container(
          padding: EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                        color: white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return EditRecipeScreen();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'Edit',
                        style: TextStyle(
                            fontSize: 20,
                            decoration: TextDecoration.underline,
                            color: Colors.blue),
                      ),
                    )
                  ],
                ),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        recipe.name,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        recipe.description,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
