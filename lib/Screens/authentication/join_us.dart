import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/GetXController/auth_controller.dart';

import 'package:task_manager/Widget/background.dart';
import 'package:task_manager/Widget/signup_form.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final double height = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          const BackGround(),
          SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(
                          MediaQuery.of(context).size.width * 0.1),
                      child: GetBuilder<AuthController>(
                        builder: (authController) {
                          return Form(
                            key: authController.formKey,
                            child: SignUpForm(
                              height: height,
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
