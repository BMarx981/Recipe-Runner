import 'package:flutter/material.dart';
import 'package:recipe_writer/models/recipe.dart';
import 'package:recipe_writer/screens/recipe_textfield.dart';
import 'package:recipe_writer/utils/colors.dart';

class EditRecipeScreen extends StatefulWidget {
  final Recipe recipe;
  EditRecipeScreen({this.recipe});

  @override
  _EditRecipeScreenState createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  final TextEditingController ingredientsController = TextEditingController();

  final TextEditingController directionsController = TextEditingController();

  final TextEditingController urlController = TextEditingController();

  final List<TextEditingController> ingredientsControllers = [];

  final List<TextEditingController> directionsControllers = [];

  bool dropped = false;

  bool ingredientExpanded = false;

  bool directionsExpanded = false;

  @override
  void initState() {
    super.initState();
    widget.recipe.ingredients.forEach(
      (element) => ingredientsControllers.add(
        TextEditingController(text: element),
      ),
    );
    widget.recipe.directions.forEach(
      (element) => directionsControllers.add(
        TextEditingController(text: element),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    titleController.text = widget.recipe.name;
    descriptionController.text = widget.recipe.description;
    ingredientsController.text = widget.recipe.ingredients[0];
    directionsController.text = widget.recipe.directions[0];

    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
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
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
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
    List<String> list,
    String title,
    bool expanded,
    List<TextEditingController> controllers,
  ) {
    List<ExpansionPanel> exPanelList = [];
    exPanelList.add(
      ExpansionPanel(
        canTapOnHeader: true,
        headerBuilder: (BuildContext context, bool expanded) {
          return Container(
              color: Colors.transparent,
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
                    color: red,
                    child: Icon(
                      Icons.add,
                      color: white,
                    ),
                    onPressed: () {
                      setState(() {
                        directionsControllers.add(TextEditingController());
                        ingredientsControllers.add(TextEditingController());
                      });
                    },
                  )
                ],
              ));
        },
        isExpanded: expanded,
        body: Container(
          decoration: BoxDecoration(gradient: colorGrad),
          height: 200,
          child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key('$index. list[index]'),
                onDismissed: (direction) {
                  setState(() {
                    list.removeAt(index);
                    controllers.removeAt(index);
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RecipeTextField(
                    text: '${index + 1}. ${list[index]}',
                    controller: controllers[index],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
    return exPanelList;
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

//class RecipeTextFieldItem extends StatelessWidget {
//  const RecipeTextFieldItem({
//    Key key,
//  }) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: const EdgeInsets.all(8.0),
//      child: RecipeTextField(
//        text: '${index + 1}. ${list[index]}',
//        controller: controllers[index],
//      ),
//    );
//  }
//}
