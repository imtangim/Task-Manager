import 'package:flutter/material.dart';

class PostNewButton extends StatelessWidget {
  final Function()? ontap;
  final String title;
  final Color color;
  const PostNewButton({
    super.key,
    this.ontap,
    required this.title,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: ontap != null ? () => ontap!() : null,
      child: Container(
        height: 20,
        width: 70,
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10), color: color
                //
                ),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ),
    );
  }
}
