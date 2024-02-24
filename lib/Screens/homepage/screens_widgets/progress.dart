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
      height: context.height - 175,
      child: Stack(
        children: [
          const PlainBackGround(),
          SingleChildScrollView(
            child: Column(
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
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return JumpingDots();
                              } else if (snapshot.hasData &&
                                  snapshot.data!.isNotEmpty) {
                                final dataMap = snapshot.data ?? {};
                                return PieChart(
                                  chartType: ChartType.ring,
                                  ringStrokeWidth: 18,
                                  dataMap: dataMap,
                                  centerText: "Summary",
                                  chartLegendSpacing: 50,
                                  chartValuesOptions: const ChartValuesOptions(
                                    showChartValuesOutside: true,
                                    showChartValuesInPercentage: true,
                                  ),
                                  chartRadius:
                                      MediaQuery.of(context).size.width / 2,
                                  animationDuration:
                                      const Duration(milliseconds: 800),
                                  legendOptions: const LegendOptions(
                                    showLegendsInRow: true,
                                    legendPosition: LegendPosition.bottom,
                                  ),
                                );
                              } else {
                                return const Text("error");
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Alerts",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleLarge!
                                        .copyWith(fontFamily: "universal_font"),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    child: const Text("See All"),
                                  )
                                ],
                              ),
                            ),
                            FutureBuilder(
                                future: controller
                                    .fetchTaskByCatagory("In_progress"),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 20.0, horizontal: 20),
                                      child: JumpingDots(),
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
                                    // return Expanded(
                                    //   child: ListView.builder(
                                    //     padding: const EdgeInsets.symmetric(
                                    //         horizontal: 10, vertical: 20),
                                    //     itemCount:
                                    //         tasks.length > 3 ? 3 : tasks.length,
                                    //     itemBuilder: (context, index) {
                                    //       ;
                                  } else {
                                    return const Text("error");
                                  }
                                }),
                          ],
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
          Container()
        ],
      ),
    );
  }
}
