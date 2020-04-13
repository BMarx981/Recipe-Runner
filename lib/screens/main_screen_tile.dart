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
                child: Icon(
                  Icons.beach_access,
                )), //To be the image of the recipe
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    'Recipe Title',
                    style: TextStyle(color: white),
                  ), //Title of recipe
                  SizedBox(height: 8),
                  Text(
                    'This is a description of the recipe to help you understand what you are looking at.',
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
