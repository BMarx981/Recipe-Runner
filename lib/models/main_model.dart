import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recipe_writer/utils/db_helper.dart';

import 'recipe.dart';

class MainModel extends ChangeNotifier {
  void populateRecipes() async {
    List<Map<String, dynamic>> maps = await dbHelper.queryAllRows();
    maps.forEach((map) {
      Recipe rec = Recipe.fromDB(map);
      addRecipe(rec);
    });
    print(recipes.length);
  }

  final dbHelper = DatabaseHelper.instance;

  String title;
  String description;
  String imageURL = '🍔';
  String url;
  List<String> directions = [];
  List<String> ingredients = [];

  //The list of recipes for the main screen.
  List<Recipe> recipes = [
    Recipe(
        name: 'Roasted Garlic',
        description:
            'This is the most delicious roasted garlic recipe you will ever find. It\'s amazing',
        imageURL: '🍔',
        ingredients: [
          '2 cloves of garlic',
          '1/2 onion',
          '2 tbls butter',
        ],
        directions: [
          'Heat oven to 350 degrees',
          'chop garlic',
          'chop onion',
          'melt butter in a pan with onion',
          'place garlic in a pan',
          'put it in the oven for 45 minutes'
        ]),
    Recipe(
      name: 'Recipe Title',
      description:
          'This is a description of the recipe to help you understand what you are looking at.',
      imageURL: '🍔',
    ),
    Recipe(
      name: 'Recipe Title',
      description:
          'This is a description of the recipe to help you understand what you are looking at.',
      imageURL: '🍔',
    ),
  ];

  //A List of the search Results from the search screen
  List<Recipe> searchResults = [];

  //Adds a recipe to the search results screen
  void addSearchResults(Recipe recipe) {
    searchResults.add(recipe);
    notifyListeners();
  }

  // Adds a recipe to the main screen
  void addRecipe(Recipe recipe) {
    recipes.add(recipe);
    notifyListeners();
  }
}
