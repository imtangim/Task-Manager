import 'package:flutter/material.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:get/get.dart';
import 'package:task_manager/Data/models/task_model.dart';
import 'package:task_manager/GetXController/task_controller.dart';
import 'package:task_manager/Widget/plainbackground.dart';
import 'package:task_manager/Widget/taskcard.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height - (context.height * 0.214),
      child: Stack(
        children: [
          const PlainBackGround(),
          GetBuilder<TaskController>(builder: (controller) {
            return controller.showAllProgress
                ? UpcomingTask(
                    controller: controller,
                  )
                : const SingleChildScrollView(child: SummaryScreen());
          }),
        ],
      ),
    );
  }
}

class UpcomingTask extends StatelessWidget {
  final TaskController controller;
  const UpcomingTask({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height,
      width: context.width,
      child: FutureBuilder(
          future: controller.fetchTaskByCatagory("In_progress"),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return JumpingDots(
                color: Colors.green,
              );
            } else if (snapshot.hasError) {
              // If there's an error, show an error message
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.data!.isEmpty) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Upcoming",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontFamily: "universal_font",
                                  ),
                        ),
                        GetBuilder<TaskController>(builder: (controller) {
                          return TextButton(
                            onPressed: () => controller.changeShow(),
                            child: const Text("Hide"),
                          );
                        }),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    width: context.width,
                    child: Center(
                      child: Text(
                        "No Task Found",
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  )
                ],
              );
            } else {
              List<TaskModel> tasks = snapshot.data!;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Upcoming",
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontFamily: "universal_font",
                                  ),
                        ),
                        GetBuilder<TaskController>(builder: (controller) {
                          return TextButton(
                            onPressed: () => controller.changeShow(),
                            child: const Text("Hide"),
                          );
                        }),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        TaskModel task = tasks[index];

                        return TaskCard(
                          isFromAler: true,
                          color: const Color.fromARGB(255, 23, 193, 232),
                          title: task.title,
                          description: task.description,
                          date: task.createdDate,
                          catagory: "Ongoing",
                          new_Ontap: () {},
                          delete_ontap: () {},
                          edit_Ontap: () {},
                        );
                      },
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }
}

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            height: context.height * 0.45,
            width: context.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: GetBuilder<TaskController>(
              builder: (controller) {
                return FutureBuilder(
                    future: controller.dataMapForPieChart(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return JumpingDots(
                          color: Colors.green,
                        );
                      } else if (snapshot.hasData &&
                          snapshot.data!.isNotEmpty) {
                        final dataMap = snapshot.data ?? {};
                        return PieChart(
                          chartType: ChartType.ring,
                          colorList: const [
                            Colors.blue,
                            Colors.redAccent,
                            Colors.purpleAccent
                          ],
                          ringStrokeWidth: 18,
                          dataMap: dataMap,
                          centerText: "Summary",
                          chartLegendSpacing: 50,
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValuesOutside: true,
                            showChartValuesInPercentage: true,
                          ),
                          chartRadius: MediaQuery.of(context).size.width / 2,
                          animationDuration: const Duration(milliseconds: 800),
                          legendOptions: const LegendOptions(
                            showLegendsInRow: true,
                            legendPosition: LegendPosition.bottom,
                          ),
                        );
                      } else {
                        return PieChart(
                          chartType: ChartType.ring,
                          ringStrokeWidth: 18,
                          colorList: const [Colors.green],
                          baseChartColor: Colors.green,
                          dataMap: const {"No Task": 1},
                          centerText: "Summary",
                          chartLegendSpacing: 50,
                          chartValuesOptions: const ChartValuesOptions(
                            showChartValues: false,
                          ),
                          chartRadius: MediaQuery.of(context).size.width / 2,
                          animationDuration: const Duration(milliseconds: 800),
                          legendOptions: const LegendOptions(
                            showLegendsInRow: true,
                            legendPosition: LegendPosition.bottom,
                          ),
                        );
                      }
                    });
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Container(
            width: context.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: GetBuilder<TaskController>(
              builder: (controller) {
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Alerts",
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(fontFamily: "universal_font"),
                          ),
                          GetBuilder<TaskController>(builder: (controller) {
                            return TextButton(
                              onPressed: () => controller.changeShow(),
                              child: const Text("See All"),
                            );
                          })
                        ],
                      ),
                    ),
                    FutureBuilder(
                        future: controller.fetchTaskByCatagory("In_progress"),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20.0, horizontal: 20),
                              child: JumpingDots(color: Colors.green),
                            );
                          } else if (snapshot.hasData &&
                              snapshot.data!.isNotEmpty) {
                            List<TaskModel> tasks = snapshot.data!;

                            return Column(
                              children: [
                                ...List.generate(
                                    tasks.length < 3 ? tasks.length : 3,
                                    (index) {
                                  TaskModel task = tasks[index];
                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20.0,
                                        left: 10,
                                        right: 10,
                                        bottom: 10),
                                    child: TaskCard(
                                      isFromAler: true,
                                      color: const Color.fromARGB(
                                          255, 23, 193, 232),
                                      title: task.title,
                                      description: task.description,
                                      date: task.createdDate,
                                      catagory: "Ongoing",
                                      new_Ontap: () {},
                                      delete_ontap: () {},
                                      edit_Ontap: () {},
                                    ),
                                  );
                                })
                              ],
                            );
                          } else {
                            return SizedBox(
                              height: 200,
                              width: context.width,
                              child: Center(
                                child: Text(
                                  "No Task Found",
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                              ),
                            );
                          }
                        }),
                  ],
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
