import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:task_manager/Data/models/task_model.dart';
import 'package:task_manager/GetXController/task_controller.dart';
import 'package:task_manager/Widget/custom_card.dart';
import 'package:task_manager/Widget/plainbackground.dart';
import 'package:task_manager/Widget/taskcard.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const PlainBackGround(),
        Column(
          children: [
            GetBuilder<TaskController>(builder: (controller) {
              return FutureBuilder(
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
                    } else if (snapshot.hasData) {
                      int total = 0;
                      for (var item in snapshot.data!) {
                        total += (item["sum"] as num).toInt();
                      }

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ...List.generate(4, (index) {
                              final item = snapshot
                                  .data?[index == 0 ? index : index - 1];
                              return CustomCard(
                                number: index == 0 ? total : item['sum'],
                                label: index == 0
                                    ? "Total"
                                    : item["_id"] == "In_progress"
                                        ? "Ongoing"
                                        : item["_id"],
                              );
                            })
                          ],
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text("Error"),
                      );
                    }
                  });
            }),
            GetBuilder<TaskController>(builder: (controller) {
              return Expanded(
                child: FutureBuilder(
                    future: controller.fetchAllCatagory(),
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
                            Map<String, dynamic> catagories = {
                              "In_progress": "Ongoing",
                              "Completed": "Done",
                              "Canceled": "Canceled",
                            };
                            return TaskCard(
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
                              new_Ontap: () {},
                              delete_ontap: () {},
                              edit_Ontap: () {},
                            );
                          },
                        );
                      }
                    }),
              );
            })
          ],
        ),
        Positioned(
          bottom: 40,
          right: 30,
          child: GetBuilder<TaskController>(builder: (taskController) {
            return IconButton(
              padding: EdgeInsets.zero,
              onPressed: () => taskController.changeTaskState(),
              icon: Container(
                height: 40,
                width: 40,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
