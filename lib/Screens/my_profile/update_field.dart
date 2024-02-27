
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:task_manager/GetXController/profile_update_controller.dart';
import 'package:task_manager/Widget/custom_textfield.dart';
import 'package:task_manager/Widget/plainbackground.dart';

class UpdateField extends StatelessWidget {
  final bool isFromPassword;
  final bool isFromName;
  final String hintText;
  final String title;
  final String subtitle;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Function() ontap;
  final bool visibility;
  UpdateField(
      {super.key,
      required this.isFromPassword,
      required this.isFromName,
      this.validator,
      required this.controller,
      required this.hintText,
      required this.title,
      required this.subtitle,
      required this.obscureText,
      required this.ontap,
      required this.visibility});

  final RegExp mobileRegExp = RegExp(r'^01\d{9}$');

  final RegExp passwordRegExp = RegExp(
    r'^(?=.*[a-zA-Z])(?=.*\d)[A-Za-z\d@#$%^&+=!_]{8,}$',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          const PlainBackGround(),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Container(
              padding: const EdgeInsets.all(10.0),
              height: context.height * 0.47,
              width: context.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                // color: Colors.white,
              ),
              child: GetBuilder<ProfileUpdateController>(
                  builder: (updateController) {
                return Form(
                  key: updateController.key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextfield(
                        controller: controller,
                        hintText: hintText,
                        obsecureText: obscureText,
                        validator: validator,
                        icon: isFromPassword
                            ? const Icon(Icons.visibility_outlined)
                            : null,
                      ),
                      isFromName
                          ? GetBuilder<ProfileUpdateController>(
                              builder: (controller) {
                              return Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomTextfield(
                                    controller:
                                        controller.lastNameTextEditingControler,
                                    hintText: "Last Name",
                                    obsecureText: false,
                                    validator: (String? value) {
                                      if (value?.trim().isEmpty ?? true) {
                                        return "Enter your lastname";
                                      }
                                      return null;
                                    },
                                  ),
                                ],
                              );
                            })
                          : const SizedBox(),
                      isFromPassword
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 5,
                                ),
                                GetBuilder<ProfileUpdateController>(
                                    builder: (updateController) {
                                  return Column(
                                    children: [
                                      CustomTextfield(
                                        controller: updateController
                                            .confirmPasswordTextEditingControler,
                                        hintText: "Confirm password",
                                        obsecureText: true,
                                        validator: (String? value) {
                                          if (value == null ||
                                              value != controller.text) {
                                            return "Password didn't match. Please confirm your password";
                                          }
                                          return null;
                                        },
                                        icon: const Icon(
                                            Icons.visibility_outlined),
                                      ),
                                      const SizedBox(
                                        height: 0,
                                      ),
                                    ],
                                  );
                                }),
                              ],
                            )
                          : const SizedBox(),
                      const SizedBox(
                        height: 20,
                      ),
                      GetBuilder<ProfileUpdateController>(
                          builder: (controller) {
                        return Visibility(
                          visible: !controller.isLoading,
                          replacement: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Center(
                              child: JumpingDots(
                                verticalOffset: 8,
                                color: Colors.white,
                                radius: 10,
                                numberOfDots: 3,
                              ),
                            ),
                          ),
                          child: ElevatedButton(
                            onPressed: ontap,
                            child: Center(
                              child: SvgPicture.asset(
                                "assets/ui/arrow.svg",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        );
                      }),
                      const SizedBox(
                        height: 48,
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
