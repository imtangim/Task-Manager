import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jumping_dot/jumping_dot.dart';
import 'package:task_manager/GetXController/profile_update_controller.dart';
import 'package:task_manager/Screens/my_profile/update_field.dart';
import 'package:task_manager/Screens/my_profile/widgets/image.dart';
import 'package:task_manager/Widget/plainbackground.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  // final ProfileUpdateController profileUpdateController =
  //     Get.put(ProfileUpdateController());

  @override
  void initState() {
    super.initState();
  }

  final RegExp emailRegExp =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  final RegExp mobileRegExp = RegExp(r'^01\d{9}$');

  final RegExp passwordRegExp = RegExp(
    r'^(?=.*[a-zA-Z])(?=.*\d)[A-Za-z\d@#$%^&+=!_]{8,}$',
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            const PlainBackGround(),
            GetBuilder<ProfileUpdateController>(builder: (controller) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: SizedBox(
                  width: context.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: !controller.isLoading,
                        replacement: SizedBox(
                          height: 200,
                          width: 200,
                          child: JumpingDots(
                            color: Colors.green,
                          ),
                        ),
                        child: InkWell(
                          onTap: () async {
                            controller.pickImage(ImageSource.gallery);
                          },
                          child: Stack(
                            children: [
                              controller.image == null
                                  ? controller.sharedPreferenceController.user
                                              ?.photo !=
                                          ""
                                      ? Base64ImagePreview(
                                          radius: 60,
                                          base64Image: controller
                                                  .sharedPreferenceController
                                                  .user!
                                                  .photo ??
                                              "",
                                        )
                                      : const CircleAvatar(
                                          backgroundImage: AssetImage(
                                            "assets/image/avatar.jpg",
                                          ),
                                          radius: 60,
                                        )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipOval(
                                          child: CircleAvatar(
                                            radius: 60,
                                            child: Image.file(
                                              controller.image!,
                                              fit: BoxFit.cover,
                                              height: 130,
                                              width: 130,
                                            ),
                                          ),
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  controller.image = null;
                                                  setState(() {});
                                                },
                                                icon: const Icon(
                                                  Icons.cancel,
                                                  color: Colors.red,
                                                )),
                                            IconButton(
                                                onPressed: () async {
                                                  await controller
                                                      .uploadImage(context);
                                                  setState(() {});
                                                },
                                                icon: const Icon(
                                                  Icons.file_upload_outlined,
                                                  color: Colors.green,
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                              Positioned(
                                bottom: controller.image == null ? 0 : 48,
                                right: controller.image == null ? 0 : 145,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.5),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(100),
                                      bottomRight: Radius.circular(100),
                                    ),
                                  ),
                                  height: 60,
                                  width: 120,
                                  child: const Center(
                                    child: Icon(
                                      Icons.photo_camera_outlined,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      controller.image == null
                          ? const SizedBox(
                              height: 20,
                            )
                          : const SizedBox(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${controller.sharedPreferenceController.user!.firstName} ${controller.sharedPreferenceController.user!.lastName}",
                            style: Theme.of(context)
                                .textTheme
                                .headlineLarge!
                                .copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "universal_font",
                                  fontSize: 24,
                                ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () => Get.to(() => UpdateField(
                                  title: "Change Name",
                                  controller:
                                      controller.firstNameTextEditingControler,
                                  isFromName: true,
                                  hintText: "First Name",
                                  obscureText: false,
                                  subtitle:
                                      "Enter your first name and last name to update.",
                                  isFromPassword: false,
                                  ontap: () async {
                                    await controller.nameUpdateField(context);
                                    setState(() {});
                                  },
                                  visibility: !controller.isLoading,
                                )),
                            child: Text(
                              "Change",
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    fontSize: 15,
                                    color: Colors.blue,
                                  ),
                            ),
                          )
                        ],
                      ),

                      //email
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: Container(
                          padding: const EdgeInsets.all(10.0),
                          height: context.height * 0.27,
                          width: context.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Changer(
                                title: "Email",
                                subtitle: controller
                                    .sharedPreferenceController.user?.email,
                                ontap: () => Get.to(() => UpdateField(
                                      ontap: () async => await controller
                                          .emailUpdateField(context),
                                      validator: (String? value) {
                                        if (value?.trim().isEmpty ?? true) {
                                          return "Email cannot be empty";
                                        }
                                        if (!emailRegExp.hasMatch(value!)) {
                                          return "Enter a valid email address";
                                        }
                                        return null;
                                      },
                                      visibility: !controller.isLoading,
                                      title: "Change Email",
                                      controller:
                                          controller.emailTextEditingControler,
                                      isFromName: false,
                                      hintText: "Email",
                                      obscureText: false,
                                      subtitle:
                                          "Enter a valid email to update your previous email.",
                                      isFromPassword: false,
                                    )),
                                controller: controller,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Changer(
                                title: "Phone Number",
                                subtitle: controller
                                    .sharedPreferenceController.user?.mobile,
                                ontap: () => Get.to(() => UpdateField(
                                      ontap: () async => await controller
                                          .phoneUpdateField(context),
                                      visibility: !controller.isLoading,
                                      title: "Change Phone Number",
                                      controller:
                                          controller.phoneTextEditingControler,
                                      isFromName: false,
                                      hintText: "Phone Number",
                                      obscureText: false,
                                      validator: (String? value) {
                                        if (value == null ||
                                            !mobileRegExp.hasMatch(value)) {
                                          return "Enter a valid mobile number'";
                                        }
                                        return null;
                                      },
                                      subtitle:
                                          "Enter a valid phone number to update your previous phone number.",
                                      isFromPassword: false,
                                    )),
                                controller: controller,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Changer(
                                ontap: () => Get.to(() => UpdateField(
                                      ontap: () async => controller
                                          .passwordUpdateField(context),
                                      visibility: !controller.isLoading,
                                      title: "Change Password",
                                      controller: controller
                                          .passwordTextEditingControler,
                                      isFromName: false,
                                      hintText: "Password",
                                      obscureText: true,
                                      validator: (String? value) {
                                        if (value == null ||
                                            !passwordRegExp.hasMatch(value) ||
                                            value.length < 8) {
                                          return "Password must contain at least letter, digit and be at least 8 characters long.";
                                        }
                                        return null;
                                      },
                                      subtitle:
                                          "Password must contain at least letter, digit and be at least 8 characters long.",
                                      isFromPassword: true,
                                    )),
                                subtitle: "Change your password",
                                title: "Password",
                                controller: controller,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
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
