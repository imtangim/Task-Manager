import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:task_manager/GetXController/share_preference_controller.dart';
import 'package:task_manager/Screens/authentication/login_screen.dart';
import 'package:task_manager/Screens/homepage/main_scren/main_bottom_bar.dart';
import 'package:task_manager/Widget/background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SharedPreferenceController sharedPreferenceController;
  @override
  void initState() {
    super.initState();
    sharedPreferenceController = Get.put(SharedPreferenceController());
    Future.delayed(const Duration(seconds: 5), () {
      gotoLogin(sharedPreferenceController);
    });
  }

  void gotoLogin(SharedPreferenceController controller) async {
    log("Checking auth state...");
    await controller.checkAuthState();
    log("State: ${controller.authState}");
    Get.offAll(
      () => controller.authState == false
          ? LoginScreen()
          : const MainBottomNavBar(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const BackGround(),
          Center(
            child: SvgPicture.asset(
              "assets/ui/logo.svg",
              fit: BoxFit.scaleDown,
            ),
          )
        ],
      ),
    );
  }
}
