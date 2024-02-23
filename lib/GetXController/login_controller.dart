// ignore_for_file: use_build_context_synchronously
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/Data/data.network_caller/network_caller.dart';
import 'package:task_manager/Data/data.network_caller/network_response.dart';
import 'package:task_manager/Data/utitlity/urls.dart';
import 'package:task_manager/Screens/homepage/main_scren/main_bottom_bar.dart';


class LoginController extends GetxController {
  final TextEditingController signinEmailTextEditingControler =
      TextEditingController();
  final TextEditingController signinPasswordTextEditingControler =
      TextEditingController();

  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>(debugLabel: '_home');

  bool isLoading = false;
  bool showSigninError = false;

  Future<void> signIn() async {
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
        );
        if (networkResponse.isSuccess) {
          // showSnackMessage(context, "Successfull.", Colors.green);
          Get.off(() => const MainBottomNavBar());
          signinClear();
        } else {
          if (networkResponse.statusCode == 401) {
            showSigninError = true;
            update();
            signinPasswordTextEditingControler.clear();
          } else {
            signinClear();
            // showSnackMessage(
            //   context,
            //   "Something went wrong. Try again latter.",
            //   Colors.red,
            // );
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
