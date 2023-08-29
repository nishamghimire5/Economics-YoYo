// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final double fontSize;
  final Alignment alignMent;
  final double verticalPadding;

  const RoundedButton({
    super.key,
    required this.text,
    required this.press,
    this.fontSize = 16,
    this.verticalPadding = 16,
    required this.alignMent,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Container(
        alignment: alignMent,
        margin: EdgeInsets.symmetric(vertical: 16),
        padding: EdgeInsets.symmetric(
          vertical: verticalPadding,
          horizontal: 30,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 15),
              blurRadius: 30,
              color: Color(0xFF666666).withOpacity(.11),
            ),
          ],
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
