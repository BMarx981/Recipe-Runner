import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipe_writer/models/recipe.dart';
import 'package:recipe_writer/screens/camera_screen.dart';
import 'package:recipe_writer/utils/colors.dart';
import 'edit_recipe_screen.dart';

class RecipeScreen extends StatefulWidget {
  final Recipe recipe;
  RecipeScreen(this.recipe);

  @override
  _RecipeScreenState createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  PageController _controller = PageController(
    initialPage: 0,
    viewportFraction: 0.75,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  PageView _buildPageView() {
    return PageView(
      controller: _controller,
      children: <Widget>[
        GestureDetector(
          onLongPress: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return EditRecipeScreen(
                    recipe: widget?.recipe ??
                        Recipe(
                          name: 'Edit name',
                          ingredients: ['a'],
                          directions: ['a'],
                        ),
                  );
                },
              ),
            ).then((value) => setState(() {}));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(),
                color: red,
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: RecipeList(
                dataList: widget.recipe.ingredients,
                title: 'ingredients',
              ),
            ),
          ),
        ),
        GestureDetector(
          onLongPress: () {
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(25.0),
                  color: Color(0xFFCDAA3B)),
              child: RecipeList(
                  dataList: widget.recipe.directions, title: 'directions'),
            ),
          ),
        ),
      ],
    );
  }

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
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          (widget.recipe.imageURL == '🍔')
                              ? Stack(
                                  alignment: Alignment.center,
                                  children: <Widget>[
                                    Container(
                                      height: 38,
                                      width: 38,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(35),
                                      ),
                                    ),
                                    IconButton(
                                      color: Colors.limeAccent,
                                      icon: Icon(
                                        Icons.photo_camera,
                                        size: 28,
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => CameraScreen(
                                                recipe: widget.recipe),
                                          ),
                                        ).then((v) => setState(() {}));
                                      },
                                    ),
                                  ],
                                )
                              : GestureDetector(
                                  onTap: () =>
                                      _showDialog(widget.recipe.imageURL),
                                  child: CircleAvatar(
                                    backgroundImage: (widget.recipe.imageURL
                                            .startsWith('http'))
                                        ? NetworkImage(widget.recipe.imageURL)
                                        : getFileImage(widget.recipe.imageURL),
                                    backgroundColor: textGrey,
                                    maxRadius: 30,
                                  ),
                                ),
                          SizedBox(width: 18),
                          Expanded(
                            child: Text(
                              widget.recipe.name,
                              style: TextStyle(
                                fontSize: 28,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: _buildPageView(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  FileImage getFileImage(String input) {
    FileImage fi;
    try {
      File f = File(input);
      fi = FileImage(f);
    } catch (e) {
      print(e);
    }
    return fi;
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

class RecipeList extends StatelessWidget {
  const RecipeList({
    Key key,
    this.dataList,
    @required this.title,
  }) : super(key: key);

  final List<String> dataList;
  final String title;

  Widget _buildFirstElement(String title) {
    TextStyle titleStyles = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 28,
      color: white,
    );
    return Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            title.toUpperCase(),
            style: titleStyles,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: (dataList != null)
          ? Column(
              children: <Widget>[
                _buildFirstElement(title),
                Expanded(
                  child: ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Container(
                          child: Text(
                            '${index + 1}. ${dataList[index]}',
                            style: TextStyle(fontSize: 20, color: white),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          : Column(
              children: <Widget>[
                _buildFirstElement(title),
                Text(
                  'No $title added yet.',
                  style: TextStyle(fontSize: 18, color: white),
                ),
              ],
            ),
    );
  }
}
