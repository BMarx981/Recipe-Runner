import 'package:flutter/material.dart';
import 'package:recipe_writer/models/recipe.dart';
import 'package:recipe_writer/utils/colors.dart';

class SearchResultTile extends StatelessWidget {
  const SearchResultTile({
    Key key,
    @required this.rec,
  }) : super(key: key);

  final Recipe rec;

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
            ],
          ),
        ),
      ),
    );
  }
}
