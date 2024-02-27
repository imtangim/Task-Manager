// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously, file_names
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/Data/data.network_caller/network_caller.dart';
import 'package:task_manager/Data/data.network_caller/network_response.dart';

import 'package:task_manager/Data/models/task_model.dart';
import 'package:task_manager/Data/utitlity/urls.dart';
import 'package:task_manager/Widget/snack_messager.dart';

class TaskStatusController extends GetxController {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  RxString selectedOption = RxString('');
  String? submittedValue;
  bool isloading = false;
  TaskModel? currentTask;

  void statusDetector(TaskModel task) {
    selectedOption.value =
        task.status == "In_progress" ? "Ongoing" : task.status;
    currentTask = task;
    update();
    // log(currentTask!.id.toString());
  }

  void handleOptionChange(String? value) {
    selectedOption.value = value!;
    update();
    log('Selected Option: $selectedOption');
  }

  Future<void> taskStatusUpdate(
      BuildContext context, String currentSelection) async {
    try {
      isloading = true;
      update();
      log(submittedValue.toString());
      if (selectedOption.value != "") {
        final NetworkResponse response = await NetworkCaller().getRequest(
          "${Urls.updateTaskStatus}/${currentTask!.id}/${currentSelection == "Ongoing" ? "In_progress" : currentSelection}",
        );

        if (response.isSuccess) {
          log(response.jsonResponse.toString());
          Get.back(
            canPop: true,
          );
          showSnackMessage(
            context,
            "Status updated.",
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
      isloading = false;
      update();
    }
  }

  Future<void> deleteTask(BuildContext context, TaskModel task) async {
    log("deleting");
    try {
      isloading = true;
      update();
      log("${Urls.deleteTaskStatus}/${task.id}");
      final NetworkResponse response = await NetworkCaller().getRequest(
        "${Urls.deleteTaskStatus}/${task.id}",
      );

      if (response.isSuccess) {
        showSnackMessage(
          context,
          "Task Deleted.",
          Colors.green,
        );
      } else {
        log(response.jsonResponse.toString());
        showSnackMessage(
          context,
          "Something went wrong. Try again letter.",
          Colors.red,
        );
      }
    } finally {
      isloading = false;
      update();
    }
  }
}
