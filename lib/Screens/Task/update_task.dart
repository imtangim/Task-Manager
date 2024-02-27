import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:task_manager/GetXController/profile_update_controller.dart';
import 'package:task_manager/Widget/custom_textfield.dart';
import 'package:task_manager/Widget/plainbackground.dart';

class UpdateTask extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function() ontap;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  const UpdateTask(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.ontap,
      required this.titleController,
      required this.descriptionController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            const PlainBackGround(),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                height: context.height * 0.67,
                width: context.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // color: Colors.white,
                ),
                child: GetBuilder<ProfileUpdateController>(
                    builder: (updateController) {
                  return Form(
                    key: updateController.key,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          subtitle,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextfield(
                          controller: titleController,
                          hintText: "Enter Title",
                          obsecureText: true,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextfield(
                          controller: descriptionController,
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
                          height: 20,
                        ),
                        GetBuilder<ProfileUpdateController>(
                            builder: (controller) {
                          return Visibility(
                            visible: !controller.isLoading,
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
                            child: ElevatedButton(
                              onPressed: ontap,
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/ui/arrow.svg",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          );
                        }),
                        const SizedBox(
                          height: 48,
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Changer extends StatelessWidget {
  final ProfileUpdateController controller;
  final String title;
  final String? subtitle;
  final Function() ontap;
  const Changer({
    super.key,
    required this.controller,
    required this.title,
    this.subtitle,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        ontap();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: 18),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  subtitle ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontSize: 16, color: Colors.grey),
                )
              ],
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
            ),
          ],
        ),
      ),
    );
  }
}
