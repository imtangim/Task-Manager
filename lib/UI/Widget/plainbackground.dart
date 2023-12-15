import 'package:flutter/material.dart';


class PlainBackGround extends StatelessWidget {
  const PlainBackGround({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(250, 248, 246, 1),
      ),
    );
  }
}
