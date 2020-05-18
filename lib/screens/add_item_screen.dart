import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_writer/models/main_model.dart';
import 'package:recipe_writer/models/recipe.dart';
import 'package:recipe_writer/utils/colors.dart';
import 'recipe_textfield.dart';
import 'package:recipe_writer/utils/db_helper.dart';

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final dbHelper = DatabaseHelper.instance;

  final titleController = TextEditingController();

  final descController = TextEditingController();

  final urlController = TextEditingController();

  RecipeTextField titleField;

  RecipeTextField descField;

  RecipeTextField urlField;

  bool colorChange = false;

  @override
  Widget build(BuildContext context) {
    titleField = RecipeTextField(
      text: 'Recipe title',
      controller: titleController,
    );
    descField = RecipeTextField(
      text: 'Add a description',
      controller: descController,
    );
    urlField = RecipeTextField(
      text: 'URL',
      controller: urlController,
    );
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 12),
          titleField,
          SizedBox(height: 12),
          descField,
          SizedBox(height: 12),
          urlField,
          SizedBox(height: 22),
          Padding(
            padding: const EdgeInsets.only(
              left: 18.0,
              right: 18,
            ),
            child: Container(
              height: 60,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(35),
                  ),
                ),
                color: Colors.grey[400],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Add',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: white),
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
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${titleController.text} recipe added'),
                    ),
                  );
                  titleField = titleField;
                  descField = descField;
                  urlField = urlField;
                  titleController.clear();
                  descController.clear();
                  urlController.clear();
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
