import 'package:flutter/material.dart';
import 'package:recipe_writer/utils/colors.dart';

class AddItemScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: <Widget>[
        Text(
          'Add a recipe.',
          style: TextStyle(
            fontSize: 20,
            color: white,
          ),
        )
      ],
    ));
  }
}
