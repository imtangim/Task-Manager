// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:task_manager/UI/Widget/custom_app_bar.dart';
import 'package:task_manager/UI/Widget/custom_card.dart';
import 'package:task_manager/UI/Widget/plainbackground.dart';
import 'package:task_manager/UI/Widget/taskcard.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const PlainBackGround(),
            Column(
              children: [
                const CustomAppBar(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ...List.generate(
                        4,
                        (index) =>
                            const CustomCard(number: 09, label: "Completed"),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        title: "Demo",
                        description: "demo demo demo demo",
                        date: "21/21/2021",
                        new_Ontap: () {},
                        delete_ontap: () {},
                        edit_Ontap: () {},
                      );
                    },
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: IconButton(
        padding: EdgeInsets.zero,
        onPressed: () {},
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
