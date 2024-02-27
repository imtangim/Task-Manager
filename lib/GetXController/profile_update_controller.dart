// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_manager/Data/data.network_caller/network_caller.dart';
import 'package:task_manager/Data/data.network_caller/network_response.dart';
import 'package:task_manager/Data/models/user_model.dart';
import 'package:task_manager/Data/utitlity/urls.dart';
import 'package:task_manager/GetXController/share_preference_controller.dart';
import 'package:task_manager/Widget/snack_messager.dart';

class ProfileUpdateController extends GetxController {
  final TextEditingController emailTextEditingControler =
      TextEditingController();
  final TextEditingController passwordTextEditingControler =
      TextEditingController();
  final TextEditingController confirmPasswordTextEditingControler =
      TextEditingController();

  final TextEditingController firstNameTextEditingControler =
      TextEditingController();
  final TextEditingController lastNameTextEditingControler =
      TextEditingController();
  final TextEditingController phoneTextEditingControler =
      TextEditingController();
  final SharedPreferenceController sharedPreferenceController =
      Get.put(SharedPreferenceController());
  GlobalKey<FormState> key = GlobalKey<FormState>();

  File? image;
  String base64Image = "";

  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) return;
      image = File(pickedImage.path);
      List<int> imageBytes = await image!.readAsBytes();
      base64Image = base64Encode(imageBytes);

      update();
    } catch (e) {
      log('Error picking image: $e');
    }
  }

  bool isLoading = false;
  Future<void> uploadImage(
    BuildContext context,
  ) async {
    try {
      isLoading = true;
      update();
      if (image != null && base64Image != "") {
        final NetworkResponse response = await NetworkCaller().postRequest(
          Urls.profileUpdate,
          body: {"photo": base64Image},
        );

        if (response.isSuccess) {
          await sharedPreferenceController.saveUserInformation(
            sharedPreferenceController.token!,
            UserModel(
              email: sharedPreferenceController.user!.email,
              firstName: sharedPreferenceController.user!.firstName,
              lastName: sharedPreferenceController.user!.lastName,
              mobile: sharedPreferenceController.user!.mobile,
              photo: base64Image,
            ),
          );
          log("email: ${sharedPreferenceController.user!.email}");
          base64Image = "";
          image = null;
          update();

          showSnackMessage(
            context,
            "Image Uploaded.",
            Colors.green,
          );
        } else {
          showSnackMessage(
            context,
            "Something went wrong. Try again letter.",
            Colors.red,
          );
        }
      } else {
        log("Failed");
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> nameUpdateField(BuildContext context) async {
    try {
      isLoading = true;
      update();
      if (firstNameTextEditingControler.text.isNotEmpty &&
          lastNameTextEditingControler.text.isNotEmpty) {
        final NetworkResponse response = await NetworkCaller().postRequest(
          Urls.profileUpdate,
          body: {
            "firstName": firstNameTextEditingControler.text.trim(),
            "lastName": lastNameTextEditingControler.text.trim()
          },
        );

        if (response.isSuccess) {
          await sharedPreferenceController.saveUserInformation(
            sharedPreferenceController.token!,
            UserModel(
              email: sharedPreferenceController.user!.email,
              firstName: firstNameTextEditingControler.text.trim(),
              lastName: lastNameTextEditingControler.text.trim(),
              mobile: sharedPreferenceController.user!.mobile,
              photo: sharedPreferenceController.user!.photo,
            ),
          );
          clearField();
          update();
          Get.back(canPop: true);
          showSnackMessage(
            context,
            "Name Changed.",
            Colors.green,
          );
        } else {
          showSnackMessage(
            context,
            "Something went wrong. Try again letter.",
            Colors.red,
          );
        }
      } else {
        log("Failed");
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> emailUpdateField(BuildContext context) async {
    try {
      isLoading = true;
      update();
      if (key.currentState!.validate()) {
        final NetworkResponse response = await NetworkCaller().postRequest(
          Urls.profileUpdate,
          body: {"email": emailTextEditingControler.text.trim()},
        );

        if (response.isSuccess) {
          await sharedPreferenceController.saveUserInformation(
            sharedPreferenceController.token!,
            UserModel(
              email: emailTextEditingControler.text.trim(),
              firstName: sharedPreferenceController.user!.firstName,
              lastName: sharedPreferenceController.user!.lastName,
              mobile: sharedPreferenceController.user!.mobile,
              photo: sharedPreferenceController.user!.photo,
            ),
          );
          clearField();
          update();
          Get.back(canPop: true);
          showSnackMessage(
            context,
            "Email account changed.",
            Colors.green,
          );
        } else {
          showSnackMessage(
            context,
            "Something went wrong. Try again letter.",
            Colors.red,
          );
        }
      } else {
        log("Failed");
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> phoneUpdateField(BuildContext context) async {
    try {
      isLoading = true;
      update();
      if (key.currentState!.validate()) {
        final NetworkResponse response = await NetworkCaller().postRequest(
          Urls.profileUpdate,
          body: {"phone": phoneTextEditingControler.text.trim()},
        );

        if (response.isSuccess) {
          await sharedPreferenceController.saveUserInformation(
            sharedPreferenceController.token!,
            UserModel(
              email: sharedPreferenceController.user!.email,
              firstName: sharedPreferenceController.user!.firstName,
              lastName: sharedPreferenceController.user!.lastName,
              mobile: phoneTextEditingControler.text.trim(),
              photo: sharedPreferenceController.user!.photo,
            ),
          );
          clearField();
          update();
          Get.back(canPop: true);
          showSnackMessage(
            context,
            "Phone number changed.",
            Colors.green,
          );
        } else {
          showSnackMessage(
            context,
            "Something went wrong. Try again letter.",
            Colors.red,
          );
        }
      } else {
        log("Failed");
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> passwordUpdateField(BuildContext context) async {
    try {
      isLoading = true;
      update();
      log((passwordTextEditingControler.text ==
              confirmPasswordTextEditingControler.text)
          .toString());
      if (key.currentState!.validate()) {
        final NetworkResponse response = await NetworkCaller().postRequest(
          Urls.profileUpdate,
          body: {"password": passwordTextEditingControler.text},
        );

        if (response.isSuccess) {
          clearField();
          update();
          Get.back(canPop: true);
          showSnackMessage(
            context,
            "Password changed.",
            Colors.green,
          );
        } else {
          showSnackMessage(
            context,
            "Something went wrong. Try again letter.",
            Colors.red,
          );
        }
      } else {
        log("Failed");
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  void clearField() {
    firstNameTextEditingControler.clear();
    lastNameTextEditingControler.clear();
    emailTextEditingControler.clear();
    passwordTextEditingControler.clear();
    phoneTextEditingControler.clear();
    confirmPasswordTextEditingControler.clear();
  }

  void dead() {
    firstNameTextEditingControler.dispose();
    lastNameTextEditingControler.dispose();
    emailTextEditingControler.dispose();
    passwordTextEditingControler.dispose();
    phoneTextEditingControler.dispose();
    confirmPasswordTextEditingControler.dispose();
  }

  @override
  void dispose() {
    dead();
    super.dispose();
  }
}
