import 'package:flutter/material.dart';

class CanceledScreen extends StatefulWidget {
  const CanceledScreen({super.key});

  @override
  State<CanceledScreen> createState() => _CanceledScreenState();
}

class _CanceledScreenState extends State<CanceledScreen> {
  @override
  Widget build(BuildContext context) {
    return const  Center(
        child: Text("Canceled Screen"),
      );
  }
}
