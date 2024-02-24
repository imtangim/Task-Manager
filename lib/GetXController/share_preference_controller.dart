import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager/Data/models/user_model.dart';
import 'package:task_manager/Screens/authentication/login_screen.dart';

class SharedPreferenceController extends GetxController {
  String? token;
  UserModel? user;
  SharedPreferences? _sharedPreferences;
  bool? authState;

  Future<void> initializePreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> saveUserInformation(
      String userToken, UserModel userModel) async {
    if (_sharedPreferences == null) {
      // Initialize preferences if not already initialized
      await initializePreferences();
    }
    await _sharedPreferences?.setString("token", userToken);
    await _sharedPreferences?.setString('user', jsonEncode(userModel.toJson()));
    token = userToken;
    user = userModel;
    authState = true;
    update();
  }

  Future<void> initializeUserCache() async {
    if (_sharedPreferences == null) {
      // Initialize preferences if not already initialized
      await initializePreferences();
    }
    token = _sharedPreferences?.getString("token");
    user = UserModel.fromJson(
      jsonDecode(_sharedPreferences?.getString('user') ?? "{}"),
    );
  }

  Future<void> checkAuthState() async {
    if (_sharedPreferences == null) {
      // Initialize preferences if not already initialized
      await initializePreferences();
    }
    token = _sharedPreferences?.getString('token');

    if (token != null) {
      await initializeUserCache();
      authState = true;
      update();
    } else {
      authState = false;
      update();
    }
  }

  Future<void> logout() async {
    if (_sharedPreferences == null) {
      // Initialize preferences if not already initialized
      await initializePreferences();
    }
    _sharedPreferences?.clear();
    authState = false;
    token = null;
    update();
    Get.offAll(() => LoginScreen());
  }
}
