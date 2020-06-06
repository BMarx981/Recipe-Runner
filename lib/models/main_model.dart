import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:recipe_writer/utils/db_helper.dart';

import 'recipe.dart';

class MainModel extends ChangeNotifier {
  final dbHelper = DatabaseHelper.instance;

  String title;
  String description;
  String imageURL = '🍔';
  String url;
  List<String> directions = [];
  List<String> ingredients = [];

  MainModel() {
    populateRecipes();
  }

  void populateRecipes() async {
    List<Map<String, dynamic>> maps = await dbHelper.queryAllRows();
    maps.forEach((map) {
      Recipe rec = Recipe.fromDB(map);
      addRecipe(rec);
    });
  }

  //The list of recipes for the main screen.
  List<Recipe> recipes = [];

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
