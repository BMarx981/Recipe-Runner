import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_writer/models/main_model.dart';

import 'main_screen_tile.dart';

class MainScreenList extends StatefulWidget {
  @override
  _MainScreenListState createState() => _MainScreenListState();
}

class _MainScreenListState extends State<MainScreenList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: Provider.of<MainModel>(context).recipes.length,
      itemBuilder: (context, index) {
        final item =
            Provider.of<MainModel>(context, listen: false).recipes[index];
        return Dismissible(
          key: UniqueKey(),
          onDismissed: (direction) {
            setState(() {
              Provider.of<MainModel>(context, listen: false)
                  .recipes
                  .removeAt(index);
            });
          },
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: MainScreenTile(
              item,
            ),
          ),
        );
      },
    );
  }
}
