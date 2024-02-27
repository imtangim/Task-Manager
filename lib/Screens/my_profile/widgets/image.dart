import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';

class Base64ImagePreview extends StatelessWidget {
  final String base64Image;
  final double radius;

  const Base64ImagePreview(
      {super.key, required this.base64Image, required this.radius});

  @override
  Widget build(BuildContext context) {
    // Decode base64 string to bytes
    Uint8List bytes = base64Decode(base64Image);

    return CircleAvatar(
      backgroundColor: Colors.green,
      maxRadius: radius,
      backgroundImage: MemoryImage(bytes), // Create image from bytes
    );
  }
}
