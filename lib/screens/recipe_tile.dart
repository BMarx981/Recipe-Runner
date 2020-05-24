import 'package:flutter/material.dart';
import 'package:recipe_writer/utils/colors.dart';
import 'package:recipe_writer/models/recipe.dart';
import 'package:provider/provider.dart';
import 'package:recipe_writer/models/main_model.dart';
import 'package:recipe_writer/utils/db_helper.dart';

class RecipeTile extends StatelessWidget {
  RecipeTile({
    Key key,
    @required this.rec,
  }) : super(key: key);

  final Recipe rec;

  final dbHelper = DatabaseHelper.instance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.all(
            Radius.circular(45.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              (rec.imageURL == null)
                  ? Expanded(child: Text('🍔'))
                  : CircleAvatar(
                      backgroundImage: NetworkImage(rec.imageURL),
                      backgroundColor: textGrey,
                      maxRadius: 35,
                    ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  rec.name,
                  softWrap: true,
                ),
              ),
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  Provider.of<MainModel>(context, listen: false)
                      .recipes
                      .add(rec);
                  dbHelper.insertRow(rec);
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${rec.name} recipe added'),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
