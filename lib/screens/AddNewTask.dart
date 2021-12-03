import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_drawer/home/cubit.dart';
import 'package:flutter_animated_drawer/home/states.dart';
import 'package:flutter_animated_drawer/main.dart';
import 'package:flutter_animated_drawer/models/task_model.dart';
import 'package:flutter_animated_drawer/shared/style.dart';
import 'package:flutter_animated_drawer/widgets/common.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({Key key}) : super(key: key);
  static const routName = '/AddNewTaskScreen';

  @override
  _AddNewTaskScreenState createState() => _AddNewTaskScreenState();
}

enum Category { study, work, personal }

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  var currentFocus;

  Category _category = Category.personal;
  unfocus() {
    currentFocus = FocusScope.of(context);

    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  void dispose() {
    currentFocus.dispose();
    super.dispose();
  }

  var scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController titleController = new TextEditingController();
  TextEditingController timeController = new TextEditingController();
  TextEditingController dateController = new TextEditingController();
  TextEditingController caregoryController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    var deviceSize = MediaQuery.of(context).size;
    return SafeArea(
      child: GestureDetector(
        onTap: unfocus,
        child: Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.chevron_left_rounded,
                            size: 45,
                          ),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()),
                            );
                          }),
                    ],
                  ),
                  SizedBox(
                      height: deviceSize.height * .2,
                      child: Image.asset('images/man.png')),
                  BlocConsumer<AppCupit, AppState>(
                    listener: (context, state) {
                      // TODO: implement listener
                    },
                    builder: (context, state) {
                      var cubit = AppCupit.get(context);
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(56.0)),
                              color: primaryColor,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: SizedBox(
                                  height: deviceSize.height * .66,
                                  child: SingleChildScrollView(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20, bottom: 15),
                                            child: Text(
                                              'New Task',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Form(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                defaultFormField(
                                                  controller: titleController,
                                                  type: TextInputType.text,
                                                  validate: (String value) {
                                                    if (value.isEmpty) {
                                                      return 'title must not be empty';
                                                    }

                                                    return null;
                                                  },
                                                  label: 'Task Title',
                                                  prefix: Icons.title,
                                                ),
                                                SizedBox(
                                                  height: 15.0,
                                                ),
                                                defaultFormField(
                                                  controller: timeController,
                                                  type: TextInputType.datetime,
                                                  onTap: () {
                                                    showTimePicker(
                                                      context: context,
                                                      initialTime:
                                                          TimeOfDay.now(),
                                                    ).then((value) {
                                                      timeController.text =
                                                          value
                                                              .format(context)
                                                              .toString();
                                                      print(value
                                                          .format(context));
                                                    });
                                                  },
                                                  validate: (String value) {
                                                    if (value.isEmpty) {
                                                      return 'time must not be empty';
                                                    }

                                                    return null;
                                                  },
                                                  label: 'Task Time',
                                                  prefix: Icons
                                                      .watch_later_outlined,
                                                ),
                                                SizedBox(
                                                  height: 15.0,
                                                ),
                                                defaultFormField(
                                                  controller: dateController,
                                                  type: TextInputType.datetime,
                                                  onTap: () {
                                                    showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime.now(),
                                                      lastDate: DateTime.parse(
                                                          '2080-05-03'),
                                                    ).then((value) {
                                                      dateController.text =
                                                          DateFormat.yMMMd()
                                                              .format(value);
                                                    });
                                                  },
                                                  validate: (String value) {
                                                    if (value.isEmpty) {
                                                      return 'date must not be empty';
                                                    }

                                                    return null;
                                                  },
                                                  label: 'Task Date',
                                                  prefix: Icons.calendar_today,
                                                ),
                                                SizedBox(
                                                  height: 15.0,
                                                ),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: ListTile(
                                                        title: const Text(
                                                          'Personal',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        leading:
                                                            Radio<Category>(
                                                          value:
                                                              Category.personal,
                                                          groupValue: _category,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              _category = value;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: ListTile(
                                                        title: const Text(
                                                          'Study',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        leading:
                                                            Radio<Category>(
                                                          value: Category.study,
                                                          groupValue: _category,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              _category = value;
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                ListTile(
                                                  title: const Text(
                                                    'Work',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  leading: Radio<Category>(
                                                    value: Category.work,
                                                    groupValue: _category,
                                                    onChanged: (value) {
                                                      setState(() {
                                                        _category = value;
                                                      });
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15.0,
                                          ),
                                          SizedBox(
                                            height: 55,
                                            width: deviceSize.width * 0.94,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                print(titleController.text +
                                                    '  ' +
                                                    dateController.text +
                                                    '  ' +
                                                    timeController.text +
                                                    '  ' +
                                                    _category.index.toString());
                                                cubit.model = new taskModel(
                                                    title: titleController.text,
                                                    data: dateController.text,
                                                    time: timeController.text,
                                                    status: 'no',
                                                    category: _category ==
                                                            Category.personal
                                                        ? 'personal'
                                                        : _category ==
                                                                Category.work
                                                            ? 'work'
                                                            : 'study');

                                                setState(() {
                                                  cubit.insertToDataBase();
                                                  cubit.getFromDataBase();
                                                });
                                                final value = await Navigator
                                                    .pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomePage()),
                                                );
                                              },
                                              child: Text('Save'),
                                              style: ButtonStyle(
                                                  textStyle: MaterialStateProperty
                                                      .all(TextStyle(
                                                          color: Theme.of(
                                                                  context)
                                                              .primaryTextTheme
                                                              .button
                                                              .color)),
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          secondaryColor),
                                                  shape:
                                                      MaterialStateProperty.all(
                                                          RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ))),
                                            ),
                                          )
                                        ]),
                                  ),
                                ),
                              ),
                            ),
                          ]);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
