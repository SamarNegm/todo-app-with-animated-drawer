import 'package:flutter/material.dart';
import 'package:flutter_animated_drawer/screens/empty.dart';
import 'package:flutter_animated_drawer/widgets/common.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    Key key,
    @required this.maps,
  });

  final List<Map> maps;

  Widget build(BuildContext context) {
    return (maps.length == 0)
        ? empty()
        : ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: maps.length,
            itemBuilder: (context, index) =>
                buildTaskItem(maps[index], context));
  }
}
