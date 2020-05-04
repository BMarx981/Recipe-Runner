import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_writer/models/main_model.dart';
import 'package:recipe_writer/models/recipe.dart';
import 'package:recipe_writer/utils/colors.dart';
import 'recipe_textfield.dart';

class AddItemScreen extends StatefulWidget {
  @override
  _AddItemScreenState createState() => _AddItemScreenState();
}

class _AddItemScreenState extends State<AddItemScreen> {
  final titleController = TextEditingController();

  final descController = TextEditingController();

  final urlController = TextEditingController();

  RecipeTextField title;

  RecipeTextField desc;

  RecipeTextField url;

  @override
  Widget build(BuildContext context) {
    title = RecipeTextField(
      text: 'Recipe title',
      controller: titleController,
    );
    desc = RecipeTextField(
      text: 'Add a description',
      controller: descController,
    );
    url = RecipeTextField(
      text: 'URL',
      controller: urlController,
    );
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 12),
          title,
          SizedBox(height: 12),
          desc,
          SizedBox(height: 12),
          url,
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
                  setState(() {
                    title.setIconColorWhite();
                    desc.setIconColorWhite();
                    url.setIconColorWhite();
                  });

                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${titleController.text} recipe added'),
                    ),
                  );
                  titleController.clear();
                  descController.clear();
                  urlController.clear();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
