import 'package:flutter/material.dart';
import 'package:recipe_writer/models/recipe.dart';
import 'package:recipe_writer/utils/colors.dart';

class MainScreenTile extends StatelessWidget {
  final Recipe recipe;
  MainScreenTile(this.recipe);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.all(
          Radius.circular(35.0),
        ),
      ),
      padding: EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          (recipe.imageURL.startsWith('https'))
              ? Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(recipe.imageURL),
                    backgroundColor: textGrey,
                    maxRadius: 35,
                  ),
                )
              : SizedBox(
                  width: 50,
                  child: Text(
                    recipe.imageURL ?? ' ',
                    style: TextStyle(fontSize: 40),
                  ),
                ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    recipe.name ?? ' ',
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Text(
                    recipe.description ?? ' ',
                    maxLines: 2,
                    style: TextStyle(color: Colors.black),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
