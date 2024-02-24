import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final TextEditingController controller;
  final bool obsecureText;
  final String hintText;
  final TextInputType? type;
  final String? Function(String?)? validator;
  final Function(String)? onchanged;
  final double? height;
  final Icon? icon;
  final Function()? iconMethod;
  final int? maxLine;

  const CustomTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obsecureText,
    this.type,
    this.validator,
    this.height,
    this.onchanged,
    this.icon,
    this.iconMethod,
    this.maxLine,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool isObsecure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onchanged,
      maxLines: widget.maxLine ?? 1,
      validator: widget.validator,
      keyboardType: widget.type,
      obscureText: isObsecure == true ? widget.obsecureText : false,
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hintText,
        errorMaxLines: 10,
        hintMaxLines: 10,
        constraints: const BoxConstraints(
          minHeight: 30,
        ),
        suffixIcon: widget.icon != null
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isObsecure = !isObsecure;
                    if (kDebugMode) {
                      print(isObsecure);
                    }
                  });
                },
                icon: isObsecure == true
                    ? widget.icon!
                    : const Icon(Icons.visibility_off),
              )
            : null,
      ),
    );
  }
}
