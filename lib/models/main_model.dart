import 'package:flutter/foundation.dart';

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

  void addRecipe(Recipe recipe) {
    recipes.add(recipe);
    notifyListeners();
  }
}
