import 'package:flutter/material.dart';

class PostNewButton extends StatelessWidget {
  final Function? ontap;
  const PostNewButton({
    super.key,
    this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        ontap!();
      },
      child: Container(
        height: 20,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 23, 193, 232),
        ),
        child: Center(
          child: Text(
            "New",
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