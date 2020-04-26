import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipe_writer/models/main_model.dart';
import 'package:recipe_writer/utils/colors.dart';

import 'main_screen_tile.dart';

class MainScreenList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => Divider(
        color: mainTheme,
      ),
      itemCount: Provider.of<MainModel>(context).recipes.length,
      itemBuilder: (context, index) {
        return MainScreenTile(
          //TODO: Add Swipe to dismiss
          Provider.of<MainModel>(context).recipes[index],
        );
      },
    );
  }
}
