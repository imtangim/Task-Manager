import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController controller;
  final bool obsecureText;
  final String hintText;
  final TextInputType? type;
  final String? Function(String?)? validator;
  const CustomTextfield(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obsecureText,
      this.type,
      this.validator});

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      keyboardType: widget.type,
      obscureText: widget.obsecureText,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
      ),
    );
  }
}
