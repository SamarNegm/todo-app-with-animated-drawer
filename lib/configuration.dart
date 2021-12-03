import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Color primaryGreen = Color(0xff416d6d);
List<BoxShadow> shadowList = [
  BoxShadow(color: Colors.grey[300], blurRadius: 30, offset: Offset(0, 10))
];

List<Map> categories = [
  {'name': 'Study', 'iconPath': 'images/cat.png'},
  {'name': 'Work', 'iconPath': 'images/dog.png'},
  {'name': 'Personal', 'iconPath': 'images/rabbit.png'},
];

List<Map> drawerItems = [
  {'icon': FontAwesomeIcons.atom, 'title': 'Study'},
  {'icon': Icons.business_center, 'title': 'Work'},
  {'icon': FontAwesomeIcons.houseUser, 'title': 'Personal'},
  // {'icon': FontAwesomeIcons.borderAll, 'title': 'All'},
//  {'icon': FontAwesomeIcons.userAlt, 'title': 'Profile'},
];
