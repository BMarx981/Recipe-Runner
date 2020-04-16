import 'package:flutter/material.dart';
import 'package:recipe_writer/utils/colors.dart';

class RecipeScreen extends StatelessWidget {
  final String title;
  RecipeScreen(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe $title'),
        flexibleSpace: Container(
          height: 100,
          width: 200,
          decoration: BoxDecoration(gradient: colorGrad),
        ),
        backgroundColor: mainTheme,
      ),
      body: Container(
        child: Text('blahblahblah'),
      ),
      backgroundColor: mainTheme,
    );
  }
}
