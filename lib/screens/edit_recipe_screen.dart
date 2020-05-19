import 'package:flutter/material.dart';
import 'package:recipe_writer/models/recipe.dart';
import 'package:recipe_writer/screens/recipe_textfield.dart';
import 'package:recipe_writer/utils/colors.dart';

class EditRecipeScreen extends StatelessWidget {
  final Recipe recipe;
  EditRecipeScreen({this.recipe});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController directionsController = TextEditingController();
  final TextEditingController urlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    titleController.text = recipe.name;
    descriptionController.text = recipe.description;
    ingredientsController.text = recipe.ingredients[0];
    directionsController.text = recipe.directions[0];
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
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () {
                recipe.name = titleController.text;
                recipe.description = descriptionController.text;
              },
              child: Text(
                'Save',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(gradient: colorGrad),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                _buildFields(
                  'Title',
                  titleController,
                ),
                _buildFields(
                  'Description',
                  descriptionController,
                ),
                buildEditLists(
                  'Ingredients',
                  ingredientsController,
                  recipe.ingredients,
                ),
                buildEditLists(
                  'Directions',
                  directionsController,
                  recipe.directions,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column buildEditLists(
      String title, TextEditingController controller, List<String> list) {
    String text = '';
    if (title == 'Ingredients' || recipe.ingredients.isEmpty) {
      text = 'Add Ingredient';
    }
    if (title == 'Directions' || recipe.directions.isEmpty) {
      text = 'Add Direction';
    }
    int index = 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: white,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: RecipeTextField(
                  controller: controller,
                  text: text,
                ),
              ),
              SizedBox(width: 6),
              Column(
                children: <Widget>[
                  RaisedButton(
                    color: textGrey,
                    child: Icon(
                      Icons.add,
                      color: white,
                    ),
                    onPressed: () {
                      if (index == list.length - 1) return;
                      index += 1;
                      controller.text = list.elementAt(index);
                    },
                  ),
                  RaisedButton(
                    color: textGrey,
                    child: Icon(
                      Icons.remove,
                      color: white,
                    ),
                    onPressed: () {
                      if (index == 0) return;
                      index -= 1;
                      controller.text = list.elementAt(index);
                    },
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Column _buildFields(String name, TextEditingController controller) {
    String text = '';
    if (name == 'Description') text = 'Edit description';
    if (name == 'Title') text = 'Edit title';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(name,
              maxLines: 2,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28,
                color: white,
              )),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RecipeTextField(
            controller: controller,
            text: text,
          ),
        ),
        SizedBox(height: 12),
      ],
    );
  }
}
