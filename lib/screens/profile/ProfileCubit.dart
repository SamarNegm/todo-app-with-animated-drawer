import 'package:flutter/cupertino.dart';
import 'package:flutter_animated_drawer/DataBase/cachHelper.dart';
import 'package:flutter_animated_drawer/DataBase/database.dart';
import 'package:flutter_animated_drawer/models/user_mode.dart';
import 'package:flutter_animated_drawer/screens/profile/ProfileState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileCubit extends Cubit<profileState> {
  ProfileCubit(profileState initialState) : super(initialState);
  static ProfileCubit get(context) => BlocProvider.of(context);
  static cacheHelper helper;
  users CurrentUser = users(name: 'pop', email: 'e@e.com', phone: '011111111');
  final GlobalKey<FormState> formKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController adreessController = TextEditingController();
  MyDatabase db = MyDatabase();
  users geProfileData() {
    emit(LoadingState());
    //TODO GET DATAFROM LOCAL SQL
    List<String> user = cacheHelper.getData();
    print(user.length.toString() + ';;;;;;;;;');
    CurrentUser.name = user[0];
    CurrentUser.email = user[1];
    CurrentUser.phone = user[2];
    //  db.GetProfileDaTa();
    emit(SuccessgState());
    return CurrentUser;
  }

  void save() {
    if (!formKey.currentState.validate()) {
      emit(NotVaildData());
      return;
    }
    formKey.currentState.save();
    print(
        CurrentUser.name + ' ' + CurrentUser.email + '  ' + CurrentUser.phone);
    UpdateProfile();
  }

  void UpdateProfile() {
    emit(LoadingState());
    cacheHelper
        .putData([CurrentUser.name, CurrentUser.email, CurrentUser.phone]).then(
            (value) => emit(SuccessgState()));
    //   db.InsertToProfileTable(CurrentUser);
    emit(SuccessgState());
  }
}
