import 'package:flutter/material.dart';
import 'main_screen_tile.dart';
import 'package:recipe_writer/utils/colors.dart';

class MainScreenList extends StatelessWidget {
  const MainScreenList({
    Key key,
    @required this.list,
  }) : super(key: key);

  final List<MainScreenTile> list;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => Divider(
        color: mainTheme,
      ),
      itemCount: list.length,
      itemBuilder: (context, index) {
        return list[index];
      },
    );
  }
}
