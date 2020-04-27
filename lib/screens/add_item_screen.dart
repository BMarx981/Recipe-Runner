import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_writer/models/main_model.dart';
import 'package:recipe_writer/models/recipe.dart';
import 'package:recipe_writer/utils/colors.dart';
import 'recipe_textfield.dart';

class AddItemScreen extends StatelessWidget {
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 12),
          RecipeTextField(
            key: UniqueKey(),
            text: 'Recipe title',
            controller: titleController,
          ),
          SizedBox(height: 12),
          RecipeTextField(
            key: UniqueKey(),
            text: 'Add a description',
            controller: descController,
          ),
          SizedBox(height: 12),
          RecipeTextField(
            key: UniqueKey(),
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
                    'Add',
                    textAlign: TextAlign.left,
                    style: TextStyle(color: textGrey),
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
                titleController.clear();
                descController.clear();
                urlController.clear();
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
