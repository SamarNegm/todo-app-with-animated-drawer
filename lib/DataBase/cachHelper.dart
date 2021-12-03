import 'package:flutter_animated_drawer/models/user_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class cacheHelper {
  static SharedPreferences sharedPreferences;
  static init() async {
    print('init');
    sharedPreferences = await SharedPreferences.getInstance();
    print('done');
  }

  static Future<bool> putData(List<String> value) {
    return sharedPreferences.setStringList('CurrentUser', value);
  }

  static List<String> getData() {
    print('hiiiiiiiiiiiiiiiii');

    return sharedPreferences.getStringList('CurrentUser') ??
        ['pop', 's@s.com', '090909090'];
  }
}
