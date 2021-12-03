import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_drawer/home/cubit.dart';
import 'package:flutter_animated_drawer/home/states.dart';
import 'package:flutter_animated_drawer/shared/style.dart';
import 'package:flutter_animated_drawer/widgets/CategoryWidget.dart';
import 'package:flutter_animated_drawer/widgets/taskWidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryDetails extends StatelessWidget {
  static const routName = '/CategoryDetais';

  @override
  Widget build(BuildContext context) {
    String category = ModalRoute.of(context).settings.arguments as String;
    List CategoryTasks = [];
    category = category.toLowerCase();
    print(category);
    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<AppCupit, AppState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var deviceSize = MediaQuery.of(context).size;
            List CategoryTasks = [];
            if (category == 'study')
              CategoryTasks = AppCupit.get(context).stdyTasksList;
            else if (category == 'work')
              CategoryTasks = AppCupit.get(context).workTasksList;
            else
              CategoryTasks = AppCupit.get(context).personalTasksList;
            return state is AppGetDatabaseLoadingState
                ? Center(child: CircularProgressIndicator())
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: deviceSize.height * .43,
                        child: Stack(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(70),
                                        bottomRight: Radius.circular(70)))),
                            Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  child: SizedBox(
                                      height: deviceSize.height * .3,
                                      child:
                                          Image.asset('images/$category.png')),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(30.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      category.toUpperCase() + ' TASKS',
                                      style: Theme.of(context)
                                          .primaryTextTheme
                                          .headline1,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Stack(
                          children: [
                            CategoryWidget(maps: CategoryTasks),
                          ],
                        ),
                      ))
                    ],
                  );
          },
        ),
      ),
    );
  }
}
