import 'package:flutter/material.dart';
import 'package:recipe_writer/models/recipe.dart';
import 'recipe_tile.dart';
import 'recipe_screen.dart';

class SearchResultTile extends StatelessWidget {
  const SearchResultTile({
    Key key,
    @required this.rec,
  }) : super(key: key);

  final Recipe rec;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return RecipeScreen(
                rec,
              );
            },
          ),
        );
      },
      child: RecipeTile(rec: rec),
    );
  }
}
