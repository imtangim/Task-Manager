// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:task_manager/Widget/customiconbutton.dart';

import 'package:task_manager/Widget/newpostbutton.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final String catagory;
  final Color color;
  final Function() new_Ontap;
  final Function() edit_Ontap;
  final Function() delete_ontap;
  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.new_Ontap,
    required this.edit_Ontap,
    required this.delete_ontap,
    required this.catagory, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          right: 15,
          top: 15,
          bottom: 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              description,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                    fontSize: 9,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PostNewButton(
                  color: color,

                  title: catagory,
                  ontap: new_Ontap,
                ),
                // Update Icon
                Text(
                  "Date: $date",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(
                  width: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomIconButton(
                        ontap: () {},
                        icons: Icons.edit_document,
                        color: const Color.fromARGB(
                          255,
                          49,
                          192,
                          123,
                        ),
                      ),
                      CustomIconButton(
                        ontap: () {},
                        icons: Icons.delete,
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
                //Delete icon
              ],
            ),
          ],
        ),
      ),
    );
  }
}
