import 'package:flutter/material.dart';
import 'package:recipe_writer/screens/recipe_screen.dart';
import 'package:recipe_writer/utils/colors.dart';
import 'package:recipe_writer/models/recipe.dart';

class MainScreenTile extends StatelessWidget {
  final Recipe recipe;
  MainScreenTile(this.recipe);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return RecipeScreen(
                recipe,
              );
            },
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(2.0, 5.0),
            )
          ],
          gradient: colorGrad,
          border: Border.all(width: 1.0),
        ),
        padding: EdgeInsets.all(4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SizedBox(
              width: 75,
              child: Text(
                recipe.symbol,
                style: TextStyle(fontSize: 40),
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    recipe.name,
                    style: TextStyle(color: white),
                  ),
                  SizedBox(height: 8),
                  Text(
                    recipe.description,
                    maxLines: 2,
                    style:
                        TextStyle(color: white), //brief description of recipe],
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
