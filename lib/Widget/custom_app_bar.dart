import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/GetXController/profile_update_controller.dart';
import 'package:task_manager/GetXController/share_preference_controller.dart';
import 'package:task_manager/GetXController/task_controller.dart';
import 'package:task_manager/Screens/my_profile/profile.dart';
import 'package:task_manager/Screens/my_profile/widgets/image.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.15,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(
        color: Colors.green,
      ),
      child: SafeArea(
        child: GetBuilder<SharedPreferenceController>(
          builder: (cache) {
            ImageProvider<Object>? backgroundImage = cache.user!.photo!.isEmpty
                ? (const AssetImage(
                    "assets/image/avatar.jpg",
                  )) as ImageProvider<Object>?
                : NetworkImage(
                    cache.user!.photo.toString(),
                  );
            return Row(
              children: [
                Expanded(
                  child: ListTile(
                    onTap: () {
                      Get.to(() => const MyProfile());
                    },
                    textColor: Colors.white,
                    tileColor: Colors.green,
                    leading: GetBuilder<ProfileUpdateController>(
                        builder: (controller) {
                      return controller
                                  .sharedPreferenceController.user?.photo !=
                              ""
                          ? Base64ImagePreview(
                              radius: 25,
                              base64Image: controller
                                      .sharedPreferenceController.user!.photo ??
                                  "",
                            )
                          : CircleAvatar(
                              backgroundImage: backgroundImage,
                              maxRadius: 25,
                            );
                    }),
                    title: Text(
                      "${cache.user!.firstName!} ${cache.user!.lastName!}",
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                    ),
                    subtitle: Text(
                      cache.user!.email!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontSize: 11,
                          ),
                    ),
                    iconColor: Colors.white,
                  ),
                ),
                GetBuilder<SharedPreferenceController>(builder: (cache) {
                  return GetBuilder<TaskController>(builder: (taskController) {
                    return IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        // cache.logout();
                        // taskController.taskCreateState = false;
                      },
                      splashRadius: 1,
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                    );
                  });
                }),
              ],
            );
          },
        ),
      ),
    );
  }
}
