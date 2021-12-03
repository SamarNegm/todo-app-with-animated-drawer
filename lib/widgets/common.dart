import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_animated_drawer/home/cubit.dart';
import 'package:flutter_animated_drawer/home/states.dart';
import 'package:flutter_animated_drawer/screens/CategoryDetails.dart';
import 'package:flutter_animated_drawer/screens/profile/ProfileCubit.dart';
import 'package:flutter_animated_drawer/shared/style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  bool isUpperCase = true,
  double radius = 3.0,
  @required Function function,
  @required String text,
}) =>
    Container(
      width: width,
      height: 50.0,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
    );

Widget defaultTextButton({
  @required Function function,
  @required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
      ),
    );

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required Function validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: fontColor),
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

Widget CustomInputFilde(String lable, String data, dynamic devicesize,
    TextEditingController controller, BuildContext context) {
  return Row(
    children: [
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: Text(
          lable,
          style: TextStyle(
            color: fontColor,
          ),
        ),
      ),
      Expanded(
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          color: Color(0xffF4F4F4),
          child: TextFormField(
            //   controller: controller,
            initialValue: data,
            validator: (value) {
              if (value.isEmpty) {
                return 'Invalid $lable!';
              }
            },
            onSaved: (value) {
              if (lable == 'Name')
                ProfileCubit.get(context).CurrentUser.name = value;
              else if (lable == 'Email')
                ProfileCubit.get(context).CurrentUser.email = value;
              else if (lable == 'Phone')
                ProfileCubit.get(context).CurrentUser.phone = value;
            },
            decoration: InputDecoration(
              counterStyle: TextStyle(fontSize: 20, color: Color(0xff707070)),
              fillColor: Color(0xffF4F4F4),
            ),
          ),
        ),
      ),
    ],
  );
}

Widget TaskCategory(String Category, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.pushNamed(context, CategoryDetails.routName,
          arguments: Category);
    },
    child: SizedBox(
        height: 135,
        width: 215,
        child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocConsumer<AppCupit, AppState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      var cubit = AppCupit.get(context);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          '${cubit.getCaregoryData(Category).toInt()}  tasks',
                          style: TextStyle(color: Colors.grey[400]),
                        ),
                      );
                    },
                  ),
                  Text(
                    Category,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                        fontSize: 16),
                  ),
                  BlocConsumer<AppCupit, AppState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      var cubit = AppCupit.get(context);
                      print('totalTasks ' + cubit.TotalTasks.toString());
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SliderTheme(
                          data: SliderThemeData(
                              thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 1.0),
                              overlayShape: RoundSliderOverlayShape(
                                  overlayRadius: 0.005)),
                          child: Slider(
                            activeColor: secondaryColor,
                            inactiveColor: fontColor,

                            value: cubit.getCaregoryData(Category),
                            onChanged: (value) {},
                            min: 0,
                            max: cubit.TotalTasks, // all tasks count
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ))),
  );
}

List<Color> colorsList = [
  Colors.yellow,
  Colors.green,
  Colors.blue,
  Colors.cyanAccent,
  Colors.deepOrange,
  Colors.deepPurpleAccent
];

Widget buildTaskItem(Map model, context) => Dismissible(
      direction: DismissDirection.endToStart,
      background: Stack(children: [
        SizedBox(
          height: 61,
          child: Container(
            decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(30))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Icon(Icons.delete)],
          ),
        )
      ]),
      key: UniqueKey(),
      child: SizedBox(
        height: 72,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Container(
                    child: InkWell(
                  onTap: () {
                    if (model['status'] == 'done') {
                      AppCupit.get(context).updateDataBase(
                        state: 'no',
                        id: model['id'],
                      );
                    } else {
                      AppCupit.get(context).updateDataBase(
                        state: 'done',
                        id: model['id'],
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: colorsList[model['id'] % 6], width: 2),
                    ),
                    child: Center(
                      child: model['status'] == 'done'
                          ? Icon(
                              Icons.check,
                              size: 30.0,
                              color: secondaryColor,
                            )
                          : Icon(
                              Icons.check,
                              size: 30.0,
                              color: Colors.white,
                            ),
                    ),
                  ),
                )),

                // CircleAvatar(
                //   radius: 30.0,
                //   child: Text(
                //     '${model['time']}',
                //   ),
                // ),
                // SizedBox(
                //   width: 20.0,
                // ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '${model['title']}',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.normal,
                              decoration: model['status'] == 'done'
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        ),
                      ),
                      // Text(
                      //   '${model['date']}',
                      //   style: TextStyle(
                      //     color: Colors.grey,
                      //   ),
                      //   ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                // IconButton(
                //   onPressed: () {
                //     AppCupit.get(context).updateDataBase(
                //       state: 'done',
                //       id: model['id'],
                //     );
                //   },
                //   icon: Icon(
                //     Icons.check_box,
                //     color: Colors.green,
                //   ),
                // ),
                // IconButton(
                //   onPressed: () {
                //     AppCupit.get(context).updateDataBase(
                //       state: 'archive',
                //       id: model['id'],
                //     );
                //   },
                //   icon: Icon(
                //     Icons.archive,
                //     color: Colors.black45,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
      onDismissed: (direction) {
        AppCupit.get(context).DeleteFromDataBase(
          model['id'],
        );
      },
    );
Widget buildWidgetItem(Map model, context) => Dismissible(
      direction: DismissDirection.endToStart,
      background: Stack(children: [
        SizedBox(
          height: 61,
          child: Container(
            decoration: BoxDecoration(
                color: secondaryColor,
                borderRadius: BorderRadius.all(Radius.circular(30))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [Icon(Icons.delete)],
          ),
        )
      ]),
      key: UniqueKey(),
      child: SizedBox(
        height: 92,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                Container(
                    child: InkWell(
                  onTap: () {
                    if (model['status'] == 'done') {
                      AppCupit.get(context).updateDataBase(
                        state: 'no',
                        id: model['id'],
                      );
                    } else {
                      AppCupit.get(context).updateDataBase(
                        state: 'done',
                        id: model['id'],
                      );
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: colorsList[model['id'] % 6], width: 2),
                    ),
                    child: Center(
                      child: model['status'] == 'done'
                          ? Icon(
                              Icons.check,
                              size: 30.0,
                              color: secondaryColor,
                            )
                          : Icon(
                              Icons.check,
                              size: 30.0,
                              color: Colors.white,
                            ),
                    ),
                  ),
                )),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          '${model['title']}',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.normal,
                              decoration: model['status'] == 'done'
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                '${model['date']}',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            Text(
                              '${model['time']}',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 20.0,
                ),
                // IconButton(
                //   onPressed: () {
                //     AppCupit.get(context).updateDataBase(
                //       state: 'done',
                //       id: model['id'],
                //     );
                //   },
                //   icon: Icon(
                //     Icons.check_box,
                //     color: Colors.green,
                //   ),
                // ),
                // IconButton(
                //   onPressed: () {
                //     AppCupit.get(context).updateDataBase(
                //       state: 'archive',
                //       id: model['id'],
                //     );
                //   },
                //   icon: Icon(
                //     Icons.archive,
                //     color: Colors.black45,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
      onDismissed: (direction) {
        AppCupit.get(context).DeleteFromDataBase(
          model['id'],
        );
      },
    );

// Widget tasksBuilder({
//   @required List<Map> tasks,
// }) =>
//     ConditionalBuilder(
//       condition: tasks.length > 0,
//       builder: (context) => ListView.separated(
//         itemBuilder: (context, index) {
//           return buildTaskItem(tasks[index], context);
//         },
//         separatorBuilder: (context, index) => myDivider(),
//         itemCount: tasks.length,
//       ),
//       fallback: (context) => Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Icon(
//               Icons.menu,
//               size: 100.0,
//               color: Colors.grey,
//             ),
//             Text(
//               'No Tasks Yet, Please Add Some Tasks',
//               style: TextStyle(
//                 fontSize: 16.0,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.grey,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

class CustomCheckbox extends StatefulWidget {
  final Function onChange;
  final bool isChecked;
  final double size;
  final double iconSize;
  final Color selectedColor;
  final Color selectedIconColor;
  final Color borderColor;
  final Icon checkIcon;

  CustomCheckbox(
      {this.isChecked,
      this.onChange,
      this.size,
      this.iconSize,
      this.selectedColor,
      this.selectedIconColor,
      this.borderColor,
      this.checkIcon});

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.isChecked ?? false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
          widget.onChange(_isSelected);
        });
      },
      child: AnimatedContainer(
        margin: EdgeInsets.all(4),
        duration: Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
            color: _isSelected
                ? widget.selectedColor ?? Colors.blue
                : Colors.transparent,
            borderRadius: BorderRadius.circular(3.0),
            border: Border.all(
              color: widget.borderColor ?? Colors.black,
              width: 1.5,
            )),
        width: widget.size ?? 18,
        height: widget.size ?? 18,
        child: _isSelected
            ? Icon(
                Icons.check,
                color: widget.selectedIconColor ?? Colors.white,
                size: widget.iconSize ?? 14,
              )
            : null,
      ),
    );
  }
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(
  context,
  widget,
) =>
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) {
        return false;
      },
    );

// void showToast({
//   @required String text,
//   @required ToastStates state,
// }) =>
//     Fluttertoast.showToast(
//       msg: text,
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.BOTTOM,
//       timeInSecForIosWeb: 5,
//       backgroundColor: chooseToastColor(state),
//       textColor: Colors.white,
//       fontSize: 16.0,
//     );

// enum
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;

  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }

  return color;
}
