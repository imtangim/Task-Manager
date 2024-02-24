import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:task_manager/GetXController/task_controller.dart';
import 'package:task_manager/Widget/background.dart';
import 'package:task_manager/Widget/custom_textfield.dart';

class CreateTask extends StatelessWidget {
  const CreateTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BackGround(),
        GetBuilder<TaskController>(builder: (controller) {
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15, top: 30),
              child: Form(
                key: controller.formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add New Task",
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                fontFamily: "universal_font",
                              ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfield(
                      controller: controller.subject,
                      hintText: "Subject",
                      obsecureText: false,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Subject cannot be empty.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextfield(
                      controller: controller.description,
                      hintText: "Description",
                      obsecureText: false,
                      maxLine: 10,
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Description cannot be empty.";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Visibility(
                      visible: !controller.isloading,
                      replacement: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                          child: JumpingDots(
                            verticalOffset: 8,
                            color: Colors.white,
                            radius: 10,
                            numberOfDots: 3,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(context.width / 2.23, 30),
                            ),
                            onPressed: () => controller.changeTaskState(),
                            child: Row(
                              children: [
                                Transform.flip(
                                  flipX: true,
                                  child: SvgPicture.asset(
                                    "assets/ui/arrow.svg",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Back",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(context.width / 2.23, 30),
                            ),
                            onPressed: () => controller.createNewTask(context),
                            child: Center(
                              child: Row(
                                children: [
                                  Text(
                                    "Proceed",
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge!
                                        .copyWith(
                                          color: Colors.white,
                                        ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  SvgPicture.asset(
                                    "assets/ui/arrow.svg",
                                    fit: BoxFit.fill,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        })
      ],
    );
  }
}
