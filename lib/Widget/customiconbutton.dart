import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Color? color;
  final IconData icons;
  final Function() ontap;

  const CustomIconButton({
    super.key,
    this.color,
    required this.icons,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Icon(
              icons,
              size: 18,
              color: color,
            ),
          ),
          onTap: () {
            ontap();
          },
        ),
      ),
    );
  }
}
