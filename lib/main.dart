import 'package:flutter/material.dart';
import 'package:flutter_animated_drawer/DataBase/cachHelper.dart';
import 'package:flutter_animated_drawer/home/cubit.dart';
import 'package:flutter_animated_drawer/screens/AddNewTask.dart';
import 'package:flutter_animated_drawer/screens/CategoryDetails.dart';
import 'package:flutter_animated_drawer/screens/profile/ProfileCubit.dart';
import 'package:flutter_animated_drawer/screens/profile/ProfileState.dart';
import 'package:flutter_animated_drawer/screens/profile/profil.dart';
import 'package:flutter_animated_drawer/shared/style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'drawerScreen.dart';
import 'homeScreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await cacheHelper.init();
  runApp(BlocProvider(
    create: (context) => AppCupit()..createDatabase(),
    child: MaterialApp(
      home: HomePage(),
      theme: ThemeData(
          primaryTextTheme: TextTheme(
              headline1: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          fontFamily: 'Circular',
          primaryColor: primaryColor,
          accentColor: secondaryColor,
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: inputTextFildBackground,
            labelStyle: TextStyle(color: fontColor),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              // borderSide: BorderSide(color: Colors.grey[200]),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              // borderSide: BorderSide(color: Colors.grey[200]),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              // borderSide: BorderSide(color: Colors.grey[200]),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              //    borderSide: BorderSide(color: Colors.grey[200]),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              //  borderSide: BorderSide(color: Colors.grey[200]),
            ),
          )),
      routes: {
        AddNewTaskScreen.routName: (ctx) => AddNewTaskScreen(),
        HomePage.routName: (ctx) => HomePage(),
        CategoryDetails.routName: (ctx) => CategoryDetails(),
        profile.routeName: (ctx) => profile(),
      },
    ),
  ));
}

class HomePage extends StatelessWidget {
  static const routName = '/HomeScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BlocProvider(
            create: (context) =>
                ProfileCubit(InitialProfileState())..geProfileData(),
            child: DrawerScreen(),
          ),
          BlocProvider(
            create: (context) => AppCupit()..createDatabase(),
            child: HomeScreen(),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final value = await Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => AddNewTaskScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
