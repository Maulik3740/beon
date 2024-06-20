import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  static String userNameKey = "USERNAMEKEY";
  static String userIdKey = "USERKEY";
  static String userPhoneKey = "USERPHONEKEY";
  static String userImageKey = "USERIMAGEKEY";
  static String userTypeKey = "USERTYPEKEY";
  static String userDepartment = "USERDEPARTMENTKEY";
  // static const String isLoggedInKey = 'isLoggedIn';

  //save data
  Future<bool> saveUserId(String getUserKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userIdKey, getUserKey);
  }

  Future<bool> saveUserType(String getUserType) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userTypeKey, getUserType);
  }

  Future<bool> saveUserName(String getUserName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userNameKey, getUserName);
  }

  Future<bool> saveUserDepartment(String getUserDepartment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userDepartment, getUserDepartment);
  }

  Future<bool> savePhone(String getPhone) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userPhoneKey, getPhone);
  }

  Future<bool> saveImage(String getImage) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(userImageKey, getImage);
  }

  // for getting data from shared preferences

  Future<String?> getUserName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey);
  }

  Future<String?> getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userTypeKey);
  }

  Future<String?> getUserDepartment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userDepartment);
  }

  Future<String?> getPhone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userPhoneKey);
  }

  Future<String?> getImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userImageKey);
  }

  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(userIdKey);
  }

  // static Future<bool> getLoggedInStatus() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getBool(KEYLOGIN) ?? false;
  // }

  // static Future<void> setLoggedInStatus(bool isLoggedIn) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool(KEYLOGIN, isLoggedIn);
  // }
}
