import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:task_manager/Data/models/task_model.dart';
import 'package:task_manager/GetXController/taskStatus_controller.dart';
import 'package:task_manager/GetXController/task_controller.dart';
import 'package:task_manager/Screens/Task/update_task.dart';
import 'package:task_manager/Widget/custom_card.dart';
import 'package:task_manager/Widget/plainbackground.dart';
import 'package:task_manager/Widget/taskcard.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    super.key,
  });

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final TaskStatusController _taskStatusController = TaskStatusController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const PlainBackGround(),
        GetBuilder<TaskController>(builder: (controller) {
          return Column(
            children: [
              FutureBuilder(
                  future: controller.taskCounter(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      List catagories = [
                        "Total",
                        "Active",
                        "Completed",
                        "Canceled"
                      ];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ...List.generate(
                              catagories.length,
                              (index) => CustomCard(
                                  number: 00, label: catagories[index]),
                            )
                          ],
                        ),
                      );
                    } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      int total = 0;
                      Map<String, dynamic> catagories = {
                        "Total": 0,
                        "Active": 0,
                        "Completed": 0,
                        "Canceled": 0
                      };
                      for (var item in snapshot.data!) {
                        total = total + (item["sum"] as num).toInt();
                      }
                      catagories["Total"] = total;
                      for (Map<String, dynamic> item in snapshot.data!) {
                        if (item.containsValue("In_progress")) {
                          catagories["Active"] = item["sum"];
                        }
                        if (item.containsValue("Completed")) {
                          catagories["Completed"] = item["sum"];
                        }
                        if (item.containsValue("Canceled")) {
                          catagories["Canceled"] = item["sum"];
                        }
                      }

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: catagories.entries.map((entry) {
                            String key = entry.key;
                            int value = entry.value;

                            return CustomCard(
                              number: value,
                              label: key,
                            );
                          }).toList(),
                        ),
                      );
                    } else {
                      List catagories = [
                        "Total",
                        "Active",
                        "Completed",
                        "Canceled"
                      ];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ...List.generate(
                              catagories.length,
                              (index) => CustomCard(
                                  number: 00, label: catagories[index]),
                            )
                          ],
                        ),
                      );
                    }
                  }),
              Expanded(
                child: RefreshIndicator(
                    onRefresh: () async {
                      setState(() {});
                    },
                    child: FutureBuilder(
                        future: controller.fetchAllCatagory(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: JumpingDots(
                                color: Colors.green,
                              ),
                            );
                          } else if (snapshot.hasError) {
                            // If there's an error, show an error message
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.data!.isEmpty) {
                            return Center(
                              child: Text(
                                "No Task Found",
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            );
                          } else {
                            List<TaskModel> tasks = snapshot.data!;
                            return ListView.builder(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              itemCount: tasks.length,
                              itemBuilder: (context, index) {
                                TaskModel task = tasks[index];
                                Map<String, dynamic> catagories = {
                                  "In_progress": "Ongoing",
                                  "Completed": "Done",
                                  "Canceled": "Canceled",
                                };
                                return TaskCard(
                                  isFromAler: false,
                                  color: task.status == "In_progress"
                                      ? const Color.fromARGB(255, 23, 193, 232)
                                      : task.status == "Completed"
                                          ? Colors.green
                                          : task.status == "Canceled"
                                              ? Colors.red
                                              : const Color.fromARGB(
                                                  255, 23, 193, 232),
                                  title: task.title,
                                  description: task.description,
                                  date: task.createdDate,
                                  catagory: catagories[task.status],
                                  new_Ontap: () async {
                                    _taskStatusController.statusDetector(task);

                                    customDialog(
                                        context, task, _taskStatusController);
                                  },
                                  delete_ontap: () async {
                                    await _taskStatusController.deleteTask(
                                        context, task);
                                  },
                                  edit_Ontap: () {
                                    Get.to(
                                      () => GetBuilder<TaskStatusController>(
                                        builder: (status) {
                                          return UpdateTask(
                                              title: "Update your task details",
                                              subtitle:
                                                  "Enter your new title and description here.",
                                              ontap: () {},
                                              titleController:
                                                  status.titleController,
                                              descriptionController:
                                                  status.descriptionController);
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          }
                        })),
              )
            ],
          );
        }),
        Positioned(
          bottom: 40,
          right: 30,
          child: GetBuilder<TaskController>(builder: (taskController) {
            return IconButton(
              padding: EdgeInsets.zero,
              onPressed: () => taskController.changeTaskState(),
              icon: Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 45,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Future<dynamic> customDialog(
      BuildContext context, TaskModel task, TaskStatusController controller) {
    controller.statusDetector(task);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.all(0),
          scrollable: true,
          backgroundColor: Colors.white,
          elevation: 0,
          surfaceTintColor: Colors.white,
          title: Text(
            "Change your Task status",
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
                  fontSize: 15,
                ),
          ),
          content: _taskStatusController.isloading
              ? Center(
                  child: JumpingDots(
                    color: Colors.green,
                  ),
                )
              : selectionForm(),
          actions: [
            InkWell(
              onTap: () {
                Get.back(); // Close dialog
              },
              child: Text(
                "Cancel",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            const SizedBox(
              width: 25,
            ),
            InkWell(
              onTap: () async {
                await _taskStatusController.taskStatusUpdate(
                    context, _taskStatusController.selectedOption.value);
              },
              child: Text(
                "Done",
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
          ],
        );
      },
    );
  }

  Obx selectionForm() {
    return Obx(() {
      return SizedBox(
        height: 150,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: <Widget>[
                Radio<String>(
                  materialTapTargetSize: MaterialTapTargetSize.padded,
                  value: 'Ongoing',
                  groupValue: _taskStatusController.selectedOption.value,
                  onChanged: _taskStatusController.handleOptionChange,
                ),
                const Text('Ongoing'),
              ],
            ),
            const SizedBox(width: 20.0),
            Row(
              children: <Widget>[
                Radio<String>(
                  value: 'Completed',
                  groupValue: _taskStatusController.selectedOption.value,
                  onChanged: _taskStatusController.handleOptionChange,
                ),
                const Text('Completed'),
              ],
            ),
            const SizedBox(width: 20.0),
            Row(
              children: <Widget>[
                Radio<String>(
                  value: 'Canceled',
                  groupValue: _taskStatusController.selectedOption.value,
                  onChanged: _taskStatusController.handleOptionChange,
                ),
                const Text('Canceled'),
              ],
            ),
          ],
        ),
      );
    });
  }
}
