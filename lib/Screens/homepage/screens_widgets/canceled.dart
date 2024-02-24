import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:task_manager/Data/models/task_model.dart';
import 'package:task_manager/GetXController/task_controller.dart';
import 'package:task_manager/Widget/taskcard.dart';

class CanceledScreen extends StatefulWidget {
  const CanceledScreen({super.key});

  @override
  State<CanceledScreen> createState() => _CanceledScreenState();
}

class _CanceledScreenState extends State<CanceledScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TaskController>(builder: (controller) {
      return Expanded(
        child: FutureBuilder(
            future: controller.fetchTaskByCatagory("Canceled"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: JumpingDots(
                    color: Colors.green,
                  ),
                );
              } else if (snapshot.hasError) {
                // If there's an error, show an error message
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<TaskModel> tasks = snapshot.data!;
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    TaskModel task = tasks[index];
                   
                    return TaskCard(
                      color: Colors.red,
                      title: task.title,
                      description: task.description,
                      date: task.createdDate,
                      catagory: "Canceled",
                      new_Ontap: () {},
                      delete_ontap: () {},
                      edit_Ontap: () {},
                    );
                  },
                );
              }
            }),
      );
    });
  }
}
