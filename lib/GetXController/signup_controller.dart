// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/Data/data.network_caller/network_caller.dart';
import 'package:task_manager/Data/data.network_caller/network_response.dart';
import 'package:task_manager/Data/utitlity/urls.dart';
import 'package:task_manager/Screens/authentication/login_screen.dart';
import 'package:task_manager/Widget/snack_messager.dart';

class SignupController extends GetxController {
  final TextEditingController emailTextEditingControler =
      TextEditingController();
  final TextEditingController passwordTextEditingControler =
      TextEditingController();

  final TextEditingController firstNameTextEditingControler =
      TextEditingController();
  final TextEditingController lastNameTextEditingControler =
      TextEditingController();
  final TextEditingController phoneTextEditingControler =
      TextEditingController();

  GlobalKey<FormState> signupFormKey =
      GlobalKey<FormState>(debugLabel: '_homeScreenkey');

  bool isLoading = false;

  Future<void> signup(BuildContext context) async {
    try {
      isLoading = true;
      update();
      if (signupFormKey.currentState!.validate()) {
        final NetworkResponse response = await NetworkCaller().postRequest(
          Urls.registration,
          body: {
            "email": emailTextEditingControler.text.trim(),
            "firstName": firstNameTextEditingControler.text.trim(),
            "lastName": lastNameTextEditingControler.text.trim(),
            "mobile": phoneTextEditingControler.text.trim(),
            "password": passwordTextEditingControler.text,
            "photo": ""
          },
        );

        if (response.isSuccess) {
          signupClear();
          Get.offAll(() => const LoginScreen());

          update();

          showSnackMessage(
            context,
            "Account has been created.",
            Colors.green,
          );
        } else {
          showSnackMessage(
            context,
            "Something went wrong. Try again letter.",
            Colors.red,
          );
        }
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  void signupClear() {
    emailTextEditingControler.clear();
    firstNameTextEditingControler.clear();
    lastNameTextEditingControler.clear();
    passwordTextEditingControler.clear();

    phoneTextEditingControler.clear();
  }

  @override
  void dispose() {
    emailTextEditingControler.dispose();
    firstNameTextEditingControler.dispose();
    lastNameTextEditingControler.dispose();
    passwordTextEditingControler.dispose();
    phoneTextEditingControler.dispose();
    super.dispose();
  }
}
