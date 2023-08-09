

import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final bool? obscureText;
  const CustomTextField({super.key,required this.hint,this.controller,this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText!,
        decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none
        ),
      ),
    );
  }
}
