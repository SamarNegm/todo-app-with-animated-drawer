import 'package:flutter/material.dart';
import 'package:flutter_animated_drawer/DataBase/cachHelper.dart';
import 'package:flutter_animated_drawer/configuration.dart';
import 'package:flutter_animated_drawer/home/cubit.dart';
import 'package:flutter_animated_drawer/home/states.dart';
import 'package:flutter_animated_drawer/screens/CategoryDetails.dart';
import 'package:flutter_animated_drawer/screens/profile/ProfileCubit.dart';
import 'package:flutter_animated_drawer/screens/profile/ProfileState.dart';
import 'package:flutter_animated_drawer/screens/profile/profil.dart';
import 'package:flutter_animated_drawer/shared/style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCupit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ProfileCubit.get(context);
        return Container(
            color: primaryColor,
            padding: EdgeInsets.only(top: 50, bottom: 70, left: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        cubit.CurrentUser.name,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    ],
                  ),
                  Column(
                    children: drawerItems
                        .map((element) => InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, CategoryDetails.routName,
                                    arguments: element['title']);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(
                                      element['icon'],
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(element['title'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20))
                                  ],
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(profile.routeName);
                      },
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(primaryColor),
                          overlayColor: null),
                      icon: Icon(
                        Icons.settings,
                        color: Colors.white,
                        size: 30,
                      ),
                      label: Text(
                        'Settings',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )),
                ]));
      },
    );
  }
}
