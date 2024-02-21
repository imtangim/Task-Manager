import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final int number;
  final String label;
  const CustomCard({
    super.key,
    required this.number,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10.0,
          bottom: 10,
          top: 10,
          right: 25,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "0$number",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 14,
                  ),
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 8.2,
                    color: Colors.grey,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
