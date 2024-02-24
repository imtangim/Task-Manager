import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:task_manager/GetXController/task_controller.dart';

import 'create_task.dart';
import 'dashboard.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<TaskController>(builder: (taskController) {
        return taskController.taskCreateState
            ? const CreateTask()
            :  Dashboard();
      }),
    );
  }
}
