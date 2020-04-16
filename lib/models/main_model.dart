import 'recipe.dart';
import 'package:flutter/foundation.dart';

class MainModel extends ChangeNotifier {
  String title;
  String description;
  String symbol;
  String url;
  List<Recipe> recipes = [
    Recipe(
      name: 'Recipe Title',
      description:
          'This is a description of the recipe to help you understand what you are looking at.',
      symbol: '🍔',
    ),
    Recipe(
      name: 'Recipe Title',
      description:
          'This is a description of the recipe to help you understand what you are looking at.',
      symbol: '🍔',
    ),
    Recipe(
      name: 'Recipe Title',
      description:
          'This is a description of the recipe to help you understand what you are looking at.',
      symbol: '🍔',
    ),
  ];

  void addRecipe(Recipe recipe) {
    recipes.add(recipe);
  }
}
