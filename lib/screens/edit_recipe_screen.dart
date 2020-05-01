import 'package:flutter/material.dart';
import 'package:recipe_writer/models/recipe.dart';
import 'package:recipe_writer/utils/colors.dart';

class EditRecipeScreen extends StatelessWidget {
  final Recipe recipe;
  EditRecipeScreen({this.recipe});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          elevation: 0.0,
          backgroundColor: red,
          title: Text(
            'Edit',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 34,
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(gradient: colorGrad),
                child: Text('Enter some text here.'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
