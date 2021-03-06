import 'package:flutter/material.dart';
import 'package:recipe_writer/models/recipe.dart';
import 'package:recipe_writer/screens/recipe_textfield.dart';
import 'package:recipe_writer/utils/colors.dart';
import 'package:recipe_writer/utils/db_helper.dart';

import 'camera_screen.dart';

class EditRecipeScreen extends StatefulWidget {
  final Recipe recipe;
  EditRecipeScreen({this.recipe});

  @override
  _EditRecipeScreenState createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController urlController = TextEditingController();

  final List<TextEditingController> ingredientsControllers = [];

  final List<TextEditingController> directionsControllers = [];

  final List<RecipeTextField> ingredientFields = [];

  final List<RecipeTextField> directionsFields = [];

  bool dropped = false;

  bool ingredientExpanded = true;

  bool directionsExpanded = true;

  DatabaseHelper dbh = DatabaseHelper.instance;

  @override
  void initState() {
    super.initState();
    if (widget.recipe.ingredients == null || widget.recipe.directions == null) {
      widget.recipe.ingredients = [];
      widget.recipe.directions = [];
      return;
    }
    if (widget.recipe.ingredients.isNotEmpty) {
      widget.recipe.ingredients.forEach(
        (element) {
          TextEditingController tec = TextEditingController(text: element);
          ingredientsControllers.add(
            tec,
          );
          ingredientFields.add(
            RecipeTextField(
              controller: tec,
              text: element,
              callBack: saveChanges,
            ),
          );
        },
      );
    }
    if (widget.recipe.directions.isNotEmpty) {
      widget.recipe.directions.forEach((element) {
        TextEditingController tec = TextEditingController(text: element);
        directionsControllers.add(
          tec,
        );
        directionsFields.add(
          RecipeTextField(controller: tec, text: element),
        );
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    ingredientsControllers.forEach((controller) => controller.dispose());
    directionsControllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    titleController.text = widget.recipe.name;
    descriptionController.text = widget.recipe.description;

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
            saveChanges();
          }
        },
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
                  saveChanges();
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
                  buildRaisedButton(context),
                  SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          ingredientExpanded = !ingredientExpanded;
                        });
                      },
                      children: _buildExpansionPanels(
                        context,
                        widget.recipe.ingredients,
                        'Ingredients',
                        ingredientExpanded,
                        ingredientsControllers,
                        ingredientFields,
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded) {
                        setState(() {
                          directionsExpanded = !directionsExpanded;
                        });
                      },
                      children: _buildExpansionPanels(
                        context,
                        widget.recipe.directions,
                        'Directions',
                        directionsExpanded,
                        directionsControllers,
                        directionsFields,
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  RaisedButton buildRaisedButton(BuildContext context) {
    return RaisedButton(
      elevation: 7.5,
      color: Colors.limeAccent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(35),
        ),
      ),
      child: Icon(
        Icons.photo_camera,
        color: red,
        size: 28,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CameraScreen(recipe: widget.recipe),
          ),
        ).then((v) => setState(() {}));
      },
    );
  }

  void saveChanges() {
    widget.recipe.name = titleController.text;
    widget.recipe.description = descriptionController.text;
    widget.recipe.ingredients.clear();
    ingredientsControllers.forEach((controller) {
      widget.recipe.ingredients.add(controller.text);
    });
    widget.recipe.directions.clear();
    directionsControllers.forEach((controller) {
      widget.recipe.directions.add(controller.text);
    });
  }

  List<ExpansionPanel> _buildExpansionPanels(
    BuildContext context,

    // direction or ingredients list
    List<String> list,
    String title,

    // Is the Panel expanded
    bool expanded,

    // direction or ingredients controllers
    List<TextEditingController> controllers,

    // List of recipeFields
    List<RecipeTextField> recFields,
  ) {
    List<Dismissible> itemList = [];
    list.asMap().forEach(
      (index, element) {
        itemList.add(
          Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              setState(() {
                list.removeAt(index);
                controllers.removeAt(index);
                recFields.removeAt(index);
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RecipeTextField(
                text: '${index + 1}. ${list[index]}',
                controller: controllers[index],
              ),
            ),
          ),
        );
      },
    );
    List<ExpansionPanel> exPanelList = [];
    exPanelList.add(
      ExpansionPanel(
        canTapOnHeader: true,
        headerBuilder: (BuildContext context, bool expanded) {
          return Container(
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        color: textGrey,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(35),
                    ),
                  ),
                  color: red,
                  child: Icon(
                    Icons.add,
                    color: white,
                  ),
                  onPressed: () => setState(() => addField(
                            controllers,
                            recFields,
                            list,
                          ) // recFields.add
                      ), // setState
                ),
              ],
            ),
          );
        },
        isExpanded: expanded,
        body: Container(
          decoration: BoxDecoration(gradient: colorGrad),
          height: 200,
          child: Scrollbar(
            child: ReorderableListView(
              children: itemList,
              onReorder: (oldIndex, newIndex) {
                if (oldIndex < newIndex) {
                  // removing the item at oldIndex will shorten the list by 1.
                  newIndex -= 1;
                }
                itemList.insert(newIndex, itemList.removeAt(oldIndex));
              },
            ),
          ),
        ),
      ),
    );
    return exPanelList;
  }

  void addField(List<TextEditingController> controllers,
      List<RecipeTextField> recFields, List<String> list) {
    TextEditingController tec = TextEditingController();
    controllers.add(tec);
    recFields.add(
      RecipeTextField(
        controller: tec,
      ),
    );
    saveChanges();
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
