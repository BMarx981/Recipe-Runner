import 'package:flutter/material.dart';
import 'package:recipe_writer/utils/colors.dart';

class MainScreenTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('I HAVE BEEN PUSHED!');
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: colorGrad,
          border: Border.all(width: 1.0),
        ),
        padding: EdgeInsets.all(4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(Icons.beach_access), //To be the image of the recipe
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text('Recipe Title'), //Title of recipe
                SizedBox(height: 8),
                Text('description'), //brief description of recipe],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
