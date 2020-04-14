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
          ),
          SizedBox(height: 12),
          RecipeTextField(text: 'Recipe title'),
          SizedBox(height: 12),
          RecipeTextField(text: 'Add a description'),
          SizedBox(height: 12),
          RecipeTextField(text: 'Add a direction'),
          SizedBox(height: 12),
          RecipeTextField(text: 'URL'),
        ],
      ),
    );
  }
}

class RecipeTextField extends StatelessWidget {
  final String text;
  const RecipeTextField({
    Key key,
    this.text = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (newStringValue) {
        print(newStringValue);
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: text,
        fillColor: white,
        focusColor: white,
        filled: true,
      ),
    );
  }
}
