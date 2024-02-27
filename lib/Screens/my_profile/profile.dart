import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/GetXController/profile_update_controller.dart';
import 'package:task_manager/GetXController/share_preference_controller.dart';
import 'package:task_manager/GetXController/swith_controller.dart';
import 'package:task_manager/Screens/my_profile/profile_update.dart';
import 'package:task_manager/Screens/my_profile/widgets/image.dart';
import 'package:task_manager/Widget/plainbackground.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Text("Me"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: GetBuilder<SharedPreferenceController>(builder: (cache) {
        ImageProvider<Object>? backgroundImage = cache.user!.photo!.isEmpty
            ? (const AssetImage(
                "assets/image/avatar.jpg",
              )) as ImageProvider<Object>?
            : NetworkImage(
                cache.user!.photo.toString(),
              );
        return Stack(
          children: [
            const PlainBackGround(),
            SingleChildScrollView(
              child: Column(
                children: [
                  Header(
                    backgroundImage: backgroundImage,
                    cache: cache,
                  ),
                  Column(
                    children: [
                      Settings(
                        cache: cache,
                      ),
                    ],
                  ),
                  const MyAccount(),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

class MyAccount extends StatelessWidget {
  const MyAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, right: 18, top: 5, bottom: 20),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        height: context.height * 0.22,
        width: context.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "My Account",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: "universal_font",
                    fontSize: 24,
                  ),
            ),
            const SizedBox(
              height: 15,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                "Switch to another account",
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: "universal_font",
                      fontSize: 18,
                      color: Colors.blue,
                    ),
              ),
            ),
            GetBuilder<SharedPreferenceController>(builder: (cache) {
              return TextButton(
                onPressed: () async => await cache.logout(),
                child: Text(
                  "Log Out",
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: "universal_font",
                        fontSize: 18,
                        color: Colors.red,
                      ),
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}

class Settings extends StatelessWidget {
  final SharedPreferenceController cache;
  const Settings({
    super.key,
    required this.cache,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        height: context.height * 0.45,
        width: context.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Settings",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    fontFamily: "universal_font",
                    fontSize: 24,
                  ),
            ),
            const SizedBox(
              height: 30,
            ),
            Bar(
              icon: Icons.alternate_email_rounded,
              iconColor: Colors.red,
              title: "Username",
              subtitle: "@${cache.user!.firstName}",
              showSwithc: false,
            ),
            const SizedBox(
              height: 10,
            ),
            GetBuilder<SwitchController>(builder: (controller) {
              return Bar(
                icon: Icons.all_inclusive_sharp,
                iconColor: Colors.green,
                title: "Active Status",
                subtitle: controller.switchvalue ? "On" : "Off",
                showSwithc: true,
                switchVal: controller.switchvalue,
                switchFunc: (v) {
                  controller.switchShifter();
                },
              );
            }),
            const SizedBox(
              height: 10,
            ),
            GetBuilder<SwitchController>(builder: (controller) {
              return Bar(
                  icon: Icons.notifications,
                  iconColor: const Color.fromARGB(255, 155, 146, 231),
                  title: "Notification",
                  subtitle: controller.notificationSwitchvalue ? "On" : "Off",
                  showSwithc: true,
                  switchVal: controller.notificationSwitchvalue,
                  switchFunc: (v) {
                    controller.notificationSwitchShifter();
                  });
            }),
          ],
        ),
      ),
    );
  }
}

class Bar extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final String? alternative;
  final bool showSwithc;
  final bool? switchVal;
  final Function(bool)? switchFunc;
  const Bar({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.alternative,
    required this.iconColor,
    required this.showSwithc,
    this.switchVal,
    this.switchFunc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      height: context.height * 0.1,
      width: context.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color.fromARGB(255, 248, 246, 246),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 45,
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            width: 30,
          ),
          Visibility(
            replacement: const SizedBox(
              width: 70,
            ),
            visible: showSwithc,
            child: Switch(
              value: switchVal ?? true,
              inactiveTrackColor: const Color.fromARGB(255, 233, 229, 229),
              inactiveThumbColor: const Color.fromARGB(255, 77, 75, 75),
              trackOutlineWidth: const MaterialStatePropertyAll(0),
              trackOutlineColor: const MaterialStatePropertyAll(
                  Color.fromARGB(255, 248, 246, 246)),
              onChanged: switchFunc,
            ),
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  final SharedPreferenceController cache;
  const Header({
    super.key,
    required this.backgroundImage,
    required this.cache,
  });

  final ImageProvider<Object>? backgroundImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        height: context.height * 0.15,
        width: context.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GetBuilder<ProfileUpdateController>(builder: (controller) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  controller.sharedPreferenceController.user?.photo != ""
                      ? Base64ImagePreview(
                          radius: 50,
                          base64Image: controller
                                  .sharedPreferenceController.user!.photo ??
                              "",
                        )
                      : CircleAvatar(
                          backgroundImage: backgroundImage,
                          maxRadius: 50,
                        ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "${cache.user!.firstName} ${cache.user!.lastName}",
                        overflow: TextOverflow.ellipsis,
                        style:
                            Theme.of(context).textTheme.headlineLarge!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "universal_font",
                                  fontSize: 24,
                                ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${cache.user!.email}",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              fontFamily: "universal_font",
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                      ),
                    ],
                  ),
                ],
              );
            }),
            IconButton(
              onPressed: () => Get.to(() => const UpdateProfile()),
              icon: const Icon(
                Icons.edit,
                size: 25,
              ),
            )
          ],
        ),
      ),
    );
  }
}
