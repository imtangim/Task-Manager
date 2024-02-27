// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/Data/data.network_caller/network_caller.dart';
import 'package:task_manager/Data/data.network_caller/network_response.dart';
import 'package:task_manager/Data/models/task_model.dart';
import 'package:task_manager/Data/utitlity/urls.dart';
import 'package:task_manager/Widget/snack_messager.dart';

class TaskController extends GetxController {
  TextEditingController subject = TextEditingController();
  TextEditingController description = TextEditingController();
  bool taskCreateState = false;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  bool isloading = false;
  bool showAllProgress = false;
  void changeTaskState() {
    taskCreateState = !taskCreateState;
    update();
  }

  void changeShow() {
    showAllProgress = !showAllProgress;
    update();
  }

  Future<void> createNewTask(BuildContext context) async {
    isloading = true;
    update();
    if (formkey.currentState!.validate()) {
      final NetworkResponse response = await NetworkCaller().postRequest(
        Urls.createNewTask,
        body: {
          "title": subject.text.trim(),
          "description": description.text.trim(),
          "status": "In_progress"
        },
      );
      isloading = false;
      update();
      if (response.isSuccess) {
        clear();
        showSnackMessage(context, "Task created successfully", Colors.green);
        taskCreateState = false;
        update();
      } else {
        showSnackMessage(
            context, "Failed to create task, try again.", Colors.red);
      }
    }
  }

  Future<List<TaskModel>> fetchTaskByCatagory(String catagory) async {
    List<TaskModel> allTasks = [];
    final NetworkResponse response = await NetworkCaller().getRequest(
      "${Urls.taskListCatagory}/$catagory",
    );
    for (var item in response.jsonResponse!["data"]) {
      allTasks.add(TaskModel.fromJson(item));
    }
    return allTasks;
  }

  Future<List<TaskModel>> fetchAllCatagory() async {
    List<TaskModel> allTasks = [];

    List<String> categories = ["In_progress", "Completed", "Canceled"];

    for (var category in categories) {
      final NetworkResponse response = await NetworkCaller().getRequest(
        "${Urls.taskListCatagory}/$category",
      );

      if (response.jsonResponse is Map<String, dynamic>) {
        final Map<String, dynamic> categoryData =
            response.jsonResponse as Map<String, dynamic>;

        final List<dynamic> tasksData = categoryData['data'];

        final List<TaskModel> tasks =
            tasksData.map((taskJson) => TaskModel.fromJson(taskJson)).toList();

        allTasks.addAll(tasks);
      }
    }
    return allTasks;
  }

  Future<List<dynamic>> taskCounter() async {
    final NetworkResponse response = await NetworkCaller().getRequest(
      Urls.taskCounter,
    );

    List<dynamic> result = response.jsonResponse!["data"];
    log(result.toString());
    List filteredList = result
        .where((item) =>
            item['_id'] == 'In_progress' ||
            item['_id'] == 'Canceled' ||
            item['_id'] == 'Completed')
        .toList();
    log(filteredList.toString());
    return filteredList;
  }

  Future<Map<String, double>> dataMapForPieChart() async {
    final NetworkResponse response = await NetworkCaller().getRequest(
      Urls.taskCounter,
    );

    List<dynamic> result = response.jsonResponse!["data"];
    List filteredList = result
        .where((item) =>
            item['_id'] == 'In_progress' ||
            item['_id'] == 'Canceled' ||
            item['_id'] == 'Completed')
        .toList();

    Map<String, double> dataMap = {};
    for (var item in filteredList) {
      dataMap[item["_id"] == "In_progress" ? "Ongoing" : item["_id"]] =
          item['sum'].toDouble();
    }

    log("Data");
    log(filteredList.toString());
    return dataMap;
  }

  




  void clear() {
    subject.clear();
    description.clear();
  }

  @override
  void dispose() {
    subject.dispose();
    description.dispose();
    super.dispose();
  }
}
