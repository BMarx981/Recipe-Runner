import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_writer/models/main_model.dart';
import 'package:recipe_writer/models/recipe.dart';
import 'package:recipe_writer/utils/colors.dart';

class AddItemScreen extends StatelessWidget {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final urlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          SizedBox(height: 12),
          RecipeTextField(
            text: 'Recipe title',
            controller: titleController,
          ),
          SizedBox(height: 12),
          RecipeTextField(
            text: 'Add a description',
            controller: descController,
          ),
          SizedBox(height: 12),
          RecipeTextField(
            text: 'URL',
            controller: urlController,
          ),
          SizedBox(height: 22),
          Container(
            height: 60,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(35),
                ),
              ),
              color: white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Enter',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),
              onPressed: () {
                Recipe recipe = Recipe(
                    name: titleController.text,
                    description: descController.text,
                    url: urlController.text);
                Provider.of<MainModel>(context, listen: false)
                    .addRecipe(recipe);
                String name = titleController.text;
                titleController.text = '';
                descController.text = '';
                urlController.text = '';
                Scaffold.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$name recipe added'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class RecipeTextField extends StatelessWidget {
  final String text;
  final TextEditingController controller;
  const RecipeTextField({
    Key key,
    this.text = '',
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35),
            borderSide: BorderSide(width: 0, style: BorderStyle.none),
          ),
          hintText: text,
          fillColor: white,
          focusColor: white,
          filled: true,
        ),
      ),
    );
  }
}
