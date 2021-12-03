import 'package:flutter/material.dart';

import 'package:flutter_animated_drawer/home/cubit.dart';
import 'package:flutter_animated_drawer/home/states.dart';
import 'package:flutter_animated_drawer/widgets/taskWidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Archived extends StatelessWidget {
  const Archived({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCupit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var tasks = AppCupit.get(context).archivedTasks;
        print(tasks.toString() + 'archive');

        return state == AppGetDatabaseLoadingState()
            ? Center(
                child: CircularProgressIndicator(),
              )
            : TaskWidget(maps: tasks);
      },
    );
  }
}
