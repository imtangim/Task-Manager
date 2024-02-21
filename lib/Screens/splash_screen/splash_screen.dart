import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/Screens/authentication/login_screen.dart';
import 'package:task_manager/Widget/background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    gotoLogin();
  }

  void gotoLogin() {
    Future.delayed(const Duration(seconds: 2)).then(
      (value) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false);
      },
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
