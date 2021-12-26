import 'package:flutter/material.dart';

class MyTextFields extends StatelessWidget {
  final String label;
  final controller;
  final int maxLines;
  final EdgeInsets? margin;
  final TextInputType? keyboardType;
  const MyTextFields(
      {Key? key,
      required this.label,
      this.maxLines = 1,
      this.keyboardType,
      this.margin,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.fromLTRB(margin?.left ?? 20, margin?.top ?? 20,
            margin?.right ?? 20, margin?.bottom ?? 0),
        child: TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            labelText: label,
            labelStyle: TextStyle(color: Colors.white),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide:
                  BorderSide(color: Colors.white.withOpacity(0.6), width: 2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white, width: 3),
            ),
          ),
          style: TextStyle(color: Colors.white, fontSize: 16),
          keyboardType: keyboardType,
          textInputAction: TextInputAction.done,
        ),
      );
}
