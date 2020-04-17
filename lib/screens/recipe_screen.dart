import 'package:flutter/material.dart';
import 'package:recipe_writer/utils/colors.dart';

class RecipeScreen extends StatelessWidget {
  final String title;
  RecipeScreen(this.title);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
      appBar: AppBar(
        title: Text('$title'),
        flexibleSpace: Container(
          height: 100,
          width: 200,
          decoration: BoxDecoration(gradient: colorGrad),
        ),
        backgroundColor: mainTheme,
      ),
      body: Container(
        padding: EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Title of card'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
