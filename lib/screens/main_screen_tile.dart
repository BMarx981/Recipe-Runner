import 'package:flutter/material.dart';

class MainScreenTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Icon(Icons.beach_access), //To be the image of the recipe
          Text('Recipe Title'), //Title of recipe
          Text('description'), //breif description of recipe
        ],
      ),
    );
  }
}
