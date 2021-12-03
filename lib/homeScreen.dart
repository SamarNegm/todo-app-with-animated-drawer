import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_drawer/DataBase/cachHelper.dart';
import 'package:flutter_animated_drawer/home/cubit.dart';
import 'package:flutter_animated_drawer/home/states.dart';
import 'package:flutter_animated_drawer/shared/style.dart';
import 'package:flutter_animated_drawer/widgets/common.dart';
import 'package:flutter_animated_drawer/widgets/taskWidget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const routName = '/HomeScreen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor)
          ..rotateY(isDrawerOpen ? -0.5 : 0),
        duration: Duration(milliseconds: 250),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0)),
        child: BlocConsumer<AppCupit, AppState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var Todaytasks = AppCupit.get(context).TodayTasks;

            var cubit = AppCupit.get(context);
            return Container(
              height: MediaQuery.of(context).size.height,
              child: state is AppGetDatabaseLoadingState
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              isDrawerOpen
                                  ? IconButton(
                                      icon: Icon(Icons.arrow_back_ios),
                                      onPressed: () {
                                        setState(() {
                                          xOffset = 0;
                                          yOffset = 0;
                                          scaleFactor = 1;
                                          isDrawerOpen = false;
                                        });
                                      },
                                    )
                                  : IconButton(
                                      icon: Icon(Icons.menu),
                                      onPressed: () {
                                        setState(() {
                                          xOffset = 230;
                                          yOffset = 150;
                                          scaleFactor = 0.6;
                                          isDrawerOpen = true;
                                        });
                                      }),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                              'What\'s up, ${cacheHelper.getData()[0]}!',
                              style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 20, bottom: 10),
                          child: Text('Categores',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600])),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            child: Row(
                              children: [
                                TaskCategory('Study', context),
                                TaskCategory('Personal', context),
                                TaskCategory('Work', context)
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          child: Text(
                            "Today's Tasks",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[600]),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: TaskWidget(maps: Todaytasks),
                          ),
                        ),
                        // SizedBox(
                        //     height: MediaQuery.of(context).size.height * 5,
                        //     child: state == AppGetDatabaseLoadingState()
                        //         ? Center(
                        //             child: CircularProgressIndicator(),
                        //           )
                        //         : SizedBox(
                        //             height: MediaQuery.of(context).size.height * .5,
                        //             child: Column(
                        //               children: [
                        //                 // TaskWidget(maps: Todaytasks),
                        //               ],
                        //             ),
                        //           )),
                      ],
                    ),
            );
          },
        ));
  }
}
