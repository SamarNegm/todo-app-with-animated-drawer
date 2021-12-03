import 'package:flutter/material.dart';
import 'package:flutter_animated_drawer/main.dart';
import 'package:flutter_animated_drawer/models/user_mode.dart';
import 'package:flutter_animated_drawer/screens/profile/ProfileCubit.dart';
import 'package:flutter_animated_drawer/screens/profile/ProfileState.dart';
import 'package:flutter_animated_drawer/shared/style.dart';
import 'package:flutter_animated_drawer/widgets/common.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class profile extends StatefulWidget {
  static const routeName = '/profile';
  @override
  _profileState createState() => _profileState();
}

class _profileState extends State<profile> {
  users newUser = new users();
  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); // WON'T WORK!
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    super.didChangeDependencies();
  }

  @override
  @override
  Widget build(BuildContext context) {
    final devicesize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocProvider(
        create: (context) =>
            ProfileCubit(InitialProfileState())..geProfileData(),
        child: BlocConsumer<ProfileCubit, profileState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = ProfileCubit.get(context);
            return state is LoadingState
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: devicesize.height * .15,
                          child: Container(
                            child:
                                Image(image: AssetImage('images/profile.png')),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Text(
                            cubit.CurrentUser.name,
                            style: TextStyle(
                              color: secondaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          height: devicesize.height * .52,
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Center(
                                      child: SizedBox(
                                          height: devicesize.height * .5,
                                          width: double.infinity,
                                          child: Card(
                                            elevation: 5,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(30))),
                                            color: primaryColor,
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12),
                                                        child: Text(
                                                          'Your info',
                                                          style: TextStyle(
                                                              color: fontColor,
                                                              fontSize: 24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Icon(
                                                          Icons.edit,
                                                          color: fontColor,
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Divider(),
                                                  Form(
                                                    key: cubit.formKey,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        CustomInputFilde(
                                                            'Name',
                                                            cubit.CurrentUser
                                                                .name
                                                                .toString(),
                                                            devicesize,
                                                            cubit
                                                                .nameController,
                                                            context),
                                                        CustomInputFilde(
                                                            'Email',
                                                            cubit.CurrentUser
                                                                .email
                                                                .toString(),
                                                            devicesize,
                                                            cubit
                                                                .emailController,
                                                            context),
                                                        CustomInputFilde(
                                                            'Phone',
                                                            cubit.CurrentUser
                                                                .phone
                                                                .toString(),
                                                            devicesize,
                                                            cubit
                                                                .phoneController,
                                                            context),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 50,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                              Align(
                                  alignment: Alignment.bottomCenter,
                                  child: FloatingActionButton(
                                    onPressed: () {
                                      cubit.save();
                                    },
                                    child: Text(
                                      'Ok',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                    backgroundColor: secondaryColor,
                                  )),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushReplacementNamed(HomePage.routName);
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(primaryColor),
                                    overlayColor: null),
                                icon: Icon(
                                  Icons.chevron_left_outlined,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                label: Text(
                                  'Back',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 200,
                        )
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
