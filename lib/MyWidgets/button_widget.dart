import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final bgcolor;
  final double? fontSize;
  final color;
  final VoidCallback onClicked;
  final bool disabled;
  const ButtonWidget(
      {Key? key,
      required this.text,
      this.fontSize = 17,
      this.bgcolor = Colors.black,
      this.color = Colors.white,
      required this.onClicked,
      this.disabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 8,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          primary: bgcolor,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
      onPressed: disabled ? null : onClicked,
      child: Text(
        text,
        style: TextStyle(fontSize: fontSize, color: color),
      ));
}
