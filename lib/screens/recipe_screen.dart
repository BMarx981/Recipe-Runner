import 'package:flutter/material.dart';

class RecipeScreen extends StatelessWidget {
  final String title;
  RecipeScreen(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe $title'),
      ),
      body: Container(
        child: Text('blahblahblah'),
      ),
    );
  }
}
