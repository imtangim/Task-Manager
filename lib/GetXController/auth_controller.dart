// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/Data/data.network_caller/network_caller.dart';
import 'package:task_manager/Data/data.network_caller/network_response.dart';
import 'package:task_manager/Data/utitlity/urls.dart';
import 'package:task_manager/Screens/authentication/login_screen.dart';
import 'package:task_manager/Screens/homepage/main_scren/main_bottom_bar.dart';
import 'package:task_manager/Widget/snack_messager.dart';

class AuthController extends GetxController {
  final TextEditingController emailTextEditingControler =
      TextEditingController();
  final TextEditingController passwordTextEditingControler =
      TextEditingController();
  final TextEditingController signinEmailTextEditingControler =
      TextEditingController();
  final TextEditingController signinPasswordTextEditingControler =
      TextEditingController();
  final TextEditingController firstNameTextEditingControler =
      TextEditingController();
  final TextEditingController lastNameTextEditingControler =
      TextEditingController();
  final TextEditingController phoneTextEditingControler =
      TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signformKey = GlobalKey<FormState>();
  final GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> phoneFormKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool showSigninError = false;

  Future<void> signup(BuildContext context) async {
    try {
      isLoading = true;
      update();
      if (signUpformValidator()) {
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
      signupClear();
      Get.off(() => const LoginScreen());
    }
  }

  Future<void> signIn(BuildContext context) async {
    try {
      isLoading = true;
      showSigninError = false;
      update();
      if (signformKey.currentState!.validate()) {
        final NetworkResponse networkResponse =
            await NetworkCaller().postRequest(
          Urls.login,
          body: {
            "email": signinEmailTextEditingControler.text.trim(),
            "password": signinPasswordTextEditingControler.text
          },
        );
        if (networkResponse.isSuccess) {
          showSnackMessage(context, "Successfull.", Colors.green);
          Get.off(() => const MainBottomNavBar());
          signinClear();
        } else {
          if (networkResponse.statusCode == 401) {
            showSigninError = true;
            update();
            signinPasswordTextEditingControler.clear();
          } else {
            signinClear();
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

  bool signUpformValidator() {
    if (emailFormKey.currentState!.validate() &&
        formKey.currentState!.validate() &&
        phoneFormKey.currentState!.validate() &&
        passwordFormKey.currentState!.validate()) {
      return true;
    }
    return false;
  }

  

  void signupClear() {
    emailTextEditingControler.clear();
    firstNameTextEditingControler.clear();
    lastNameTextEditingControler.clear();
    passwordTextEditingControler.clear();
    phoneTextEditingControler.clear();
  }

  void signinClear() {
    signinEmailTextEditingControler.clear();
    signinPasswordTextEditingControler.clear();
  }

  @override
  void dispose() {
    emailTextEditingControler.dispose();
    firstNameTextEditingControler.dispose();
    lastNameTextEditingControler.dispose();
    passwordTextEditingControler.dispose();
    phoneTextEditingControler.dispose();
    signinEmailTextEditingControler.dispose();
    signinPasswordTextEditingControler.dispose();
    super.dispose();
  }
}
