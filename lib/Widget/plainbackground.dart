import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlainBackGround extends StatelessWidget {
  const PlainBackGround({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: context.width,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(250, 248, 246, 1),
      ),
    );
  }
}
