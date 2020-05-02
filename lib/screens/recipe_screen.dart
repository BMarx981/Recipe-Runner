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
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: colorGrad,
          ),
          child: Container(
            padding: EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 30,
                          color: white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return EditRecipeScreen(
                                recipe: recipe,
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.only(right: 6),
                        child: Text(
                          'Edit',
                          style: TextStyle(
                              fontSize: 20,
                              decoration: TextDecoration.underline,
                              color: white),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 8),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        (recipe.imageURL == '🍔')
                            ? Expanded(
                                child: Text(
                                  '🍔',
                                  style: TextStyle(fontSize: 28),
                                ),
                              )
                            : CircleAvatar(
                                backgroundImage: NetworkImage(recipe.imageURL),
                                backgroundColor: textGrey,
                                maxRadius: 35,
                              ),
                        SizedBox(width: 18),
                        Expanded(
                          child: Text(
                            recipe.name,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: (recipe.ingredients != null)
                          ? ListView.builder(
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Text(
                                      '${index + 1}. ${recipe.ingredients[index]}',
                                      style: TextStyle(
                                          fontSize: 18, color: white)),
                                );
                              },
                              itemCount: recipe.ingredients.length,
                            )
                          : Text(
                              'No ingredients added yet.',
                              style: TextStyle(fontSize: 18, color: white),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
