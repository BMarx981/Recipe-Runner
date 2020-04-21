import 'package:flutter/material.dart';
import 'package:recipe_writer/utils/colors.dart';
import 'recipe_textfield.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController tc = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: colorGrad),
      child: Column(
        children: <Widget>[
          Expanded(child: RecipeTextField(text: 'Search', controller: tc)),
        ],
      ),
    );
  }
}
