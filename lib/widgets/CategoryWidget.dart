import 'package:flutter/material.dart';
import 'package:flutter_animated_drawer/screens/empty.dart';
import 'package:flutter_animated_drawer/widgets/common.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key key, @required this.maps}) : super(key: key);
  final List<Map> maps;

  Widget build(BuildContext context) {
    return (maps.length == 0)
        ? empty()
        : ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: maps.length,
            itemBuilder: (context, index) =>
                buildWidgetItem(maps[index], context));
  }
}
