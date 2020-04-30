import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'recipe.dart';

class MainModel extends ChangeNotifier {
  String title;
  String description;
  String imageURL = '🍔';
  String url;
  List<Recipe> recipes = [
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
    Recipe(
      name: 'Recipe Title',
      description:
          'This is a description of the recipe to help you understand what you are looking at.',
      imageURL: '🍔',
    ),
  ];

  List<Recipe> searchResults = [];

  void addSearchResults(Recipe recipe) {
    searchResults.add(recipe);
    notifyListeners();
  }

  void addRecipe(Recipe recipe) {
    recipes.add(recipe);
    notifyListeners();
  }
}
