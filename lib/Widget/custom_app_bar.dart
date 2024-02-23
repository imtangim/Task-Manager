import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/Screens/authentication/login_screen.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(
        color: Colors.green,
      ),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              onTap: () => log("Tile clicked"),
              textColor: Colors.white,
              tileColor: Colors.green,
              leading: const CircleAvatar(
                backgroundImage: AssetImage(
                  "assets/image/avatar.jpg",
                ),
                maxRadius: 25,
              ),
              title: Text(
                "Tangim Haque",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontSize: 14,
                    ),
              ),
              subtitle: Text(
                "tanjim437@gmail.com",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontSize: 11,
                    ),
              ),
              iconColor: Colors.white,
            ),
          ),
          IconButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              Get.offNamedUntil('/', (route) => true);
            },
            splashRadius: 1,
            icon: const Icon(
              Icons.exit_to_app,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
