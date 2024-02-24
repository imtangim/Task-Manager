import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/GetXController/task_controller.dart';
import 'package:task_manager/Screens/homepage/screens_widgets/canceled.dart';
import 'package:task_manager/Screens/homepage/screens_widgets/completed.dart';
import 'package:task_manager/Screens/homepage/screens_widgets/home.dart';
import 'package:task_manager/Screens/homepage/screens_widgets/progress.dart';
import 'package:task_manager/Widget/custom_app_bar.dart';

class MainBottomNavBar extends StatefulWidget {
  const MainBottomNavBar({super.key});

  @override
  State<MainBottomNavBar> createState() => _MainBottomNavBarState();
}

class _MainBottomNavBarState extends State<MainBottomNavBar> {
  int _selectedIndex = 0;

  final List<bool> _barItem = [true, false, false, false];
  final List<Widget> _screens =  [
    const HomeDashboard(),
    const CompletedScreen(),
    const CanceledScreen(),
    const ProgressScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CustomAppBar(),
            _screens[_selectedIndex],
          ],
        ),
      ),
      bottomNavigationBar: GetBuilder<TaskController>(builder: (controller) {
        return BottomNavigationBar(
          onTap: (index) {
            _barItem[_selectedIndex] = false;
            _selectedIndex = index;
            _barItem[index] = true;
            controller.taskCreateState = false;
            setState(() {});
          },
          currentIndex: _selectedIndex,
          selectedFontSize: 0,
          unselectedFontSize: 0,
          type: BottomNavigationBarType.fixed,
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          showUnselectedLabels: false,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          items: [
            customBottomBarIcon(
              context,
              const Icon(Icons.dashboard),
              "Dashboard",
              0,
            ),
            customBottomBarIcon(
              context,
              const Icon(Icons.task_alt_outlined),
              "Completed",
              1,
            ),
            customBottomBarIcon(
              context,
              const Icon(Icons.cancel),
              "Canceled",
              2,
            ),
            customBottomBarIcon(
              context,
              const Icon(Icons.golf_course_sharp),
              "Progress",
              3,
            ),
          ],
        );
      }),
    );
  }

  BottomNavigationBarItem customBottomBarIcon(
      BuildContext context, Icon icon, String label, int index) {
    return BottomNavigationBarItem(
      icon: Container(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        width: double.infinity,
        height: kBottomNavigationBarHeight,
        decoration: BoxDecoration(
          color: _barItem[index] == true ? Colors.green : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: _barItem[index] == true ? Colors.white : Colors.grey,
                    fontSize: 10,
                  ),
            ),
          ],
        ),
      ),
      label: "",
    );
  }
}
