import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BackGround extends StatelessWidget {
  const BackGround({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/ui/background.svg",
      fit: BoxFit.fill,
      height: double.maxFinite,
      width: double.infinity,
    );
  }
}
