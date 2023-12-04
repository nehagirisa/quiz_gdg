import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class CustomeTextField extends StatelessWidget {
  const CustomeTextField({
    super.key,
    required this.hintText,
    required this.contoller,
  });
  final String hintText;
  final TextEditingController contoller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: context.isMobile ? 400 : 700,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: TextField(
          style: const TextStyle(color: Colors.black),
          controller: contoller,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            contentPadding: const EdgeInsets.only(top: 10, left: 10),
          ),
        ),
      ),
    );
  }
}
