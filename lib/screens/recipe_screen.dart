import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_writer/models/recipe.dart';
import 'package:recipe_writer/utils/colors.dart';
import 'edit_recipe_screen.dart';

class RecipeScreen extends StatefulWidget {
  final Recipe recipe;
  RecipeScreen(this.recipe);

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: colorGrad,
          ),
          child: Container(
            padding: EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 30,
                          color: white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return EditRecipeScreen(
                                recipe: widget.recipe,
                              );
                            },
                          ),
                        ).then((value) => setState(() {}));
                      },
                      child: Container(
                        padding: EdgeInsets.only(right: 6),
                        child: Text(
                          'Edit',
                          style: TextStyle(
                              fontSize: 20,
                              decoration: TextDecoration.underline,
                              color: white),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 8),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        (widget.recipe.imageURL == '🍔')
                            ? Expanded(
                                child: Text(
                                  '🍔',
                                  style: TextStyle(fontSize: 28),
                                ),
                              )
                            : GestureDetector(
                                onTap: () =>
                                    _showDialog(widget.recipe.imageURL),
                                child: CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(widget.recipe.imageURL),
                                  backgroundColor: textGrey,
                                  maxRadius: 35,
                                ),
                              ),
                        SizedBox(width: 18),
                        Expanded(
                          child: Text(
                            widget.recipe.name,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: (widget.recipe.ingredients != null)
                          ? ListView.builder(
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Text(
                                    '${index + 1}. ${widget.recipe.ingredients[index]}',
                                    style:
                                        TextStyle(fontSize: 18, color: white),
                                  ),
                                );
                              },
                              itemCount: widget.recipe.ingredients.length,
                            )
                          : Text(
                              'No ingredients added yet.',
                              style: TextStyle(fontSize: 18, color: white),
                            ),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: (widget.recipe.directions != null)
                        ? ListView.builder(
                            itemCount: widget.recipe.directions.length,
                            itemBuilder: (context, index) {
                              return Container(
                                child: Text(
                                  '${index + 1}. ${widget.recipe.directions[index]}',
                                  style: TextStyle(fontSize: 18, color: white),
                                ),
                              );
                            })
                        : Text(
                            'No directions added yet.',
                            style: TextStyle(fontSize: 18, color: white),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(image) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            child: Center(
              child: Image(
                image: NetworkImage(image),
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
