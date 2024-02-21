import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/GetXController/get_binder.dart';
import 'package:task_manager/Theme/theme.dart';
import 'package:task_manager/Screens/splash_screen/splash_screen.dart';

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GetxDependencyBinder(),
      theme: ThemeShifter.lightTheme,
      color: Colors.green,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
