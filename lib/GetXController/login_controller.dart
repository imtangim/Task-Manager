// ignore_for_file: use_build_context_synchronously
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/Data/data.network_caller/network_caller.dart';
import 'package:task_manager/Data/data.network_caller/network_response.dart';
import 'package:task_manager/Data/models/user_model.dart';
import 'package:task_manager/Data/utitlity/urls.dart';
import 'package:task_manager/GetXController/share_preference_controller.dart';
import 'package:task_manager/Screens/homepage/main_scren/main_bottom_bar.dart';
import 'package:task_manager/Widget/snack_messager.dart';

class LoginController extends GetxController {
  final TextEditingController signinEmailTextEditingControler =
      TextEditingController();
  final TextEditingController signinPasswordTextEditingControler =
      TextEditingController();
  SharedPreferenceController sharedPreferenceController =
      Get.put(SharedPreferenceController());
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>(debugLabel: '_home');

  bool isLoading = false;
  bool showSigninError = false;

  Future<void> signIn(BuildContext context) async {
    try {
      isLoading = true;
      showSigninError = false;
      update();
      if (loginFormKey.currentState!.validate()) {
        final NetworkResponse networkResponse =
            await NetworkCaller().postRequest(
          Urls.login,
          body: {
            "email": signinEmailTextEditingControler.text.trim(),
            "password": signinPasswordTextEditingControler.text
          },
          islogin: true,
        );
        if (networkResponse.isSuccess) {
          //shared preference
          final Map<String, dynamic>? userdata =
              networkResponse.jsonResponse!['data'];

          await sharedPreferenceController.saveUserInformation(
            networkResponse.jsonResponse!['token'],
            UserModel(
              email: userdata?['email'],
              firstName: userdata?['firstName'],
              lastName: userdata?['lastName'],
              mobile: userdata?['mobile'],
              photo: userdata?['photo'],
            ),
          );

          showSnackMessage(
              context, "HI ${userdata?['firstName']}.", Colors.green);
          Get.off(() => const MainBottomNavBar());
          signinClear();
        } else {
          if (networkResponse.statusCode == 401 ||
              networkResponse.statusCode == -1) {
            showSigninError = true;
            update();
            signinPasswordTextEditingControler.clear();
          } else {
            signinClear();
            log(networkResponse.statusCode.toString());
            showSnackMessage(
              context,
              "Something went wrong. Try again latter.",
              Colors.red,
            );
          }
        }
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  void signinClear() {
    signinEmailTextEditingControler.clear();
    signinPasswordTextEditingControler.clear();
  }

  @override
  void dispose() {
    signinEmailTextEditingControler.dispose();
    signinPasswordTextEditingControler.dispose();
    super.dispose();
  }
}
