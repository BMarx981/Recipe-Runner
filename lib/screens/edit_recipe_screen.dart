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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Ingredients',
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
                                controller: ingredientsController,
                                text: 'Edit ingredients'),
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
                                onPressed: () {},
                              ),
                              RaisedButton(
                                color: textGrey,
                                child: Icon(
                                  Icons.remove,
                                  color: white,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Directions',
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
                                controller: directionsController,
                                text: 'Edit directions'),
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
                                onPressed: () {},
                              ),
                              RaisedButton(
                                color: textGrey,
                                child: Icon(
                                  Icons.remove,
                                  color: white,
                                ),
                                onPressed: () {},
                              ),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
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
