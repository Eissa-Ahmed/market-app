import 'package:flutter/material.dart';

Text customText({
  required String text,
  double fontSize = 16.0,
  Color colorFont = Colors.black,
  TextAlign textAlign = TextAlign.left,
  FontWeight fontWeight = FontWeight.w400,
  double height = 1.4,
}) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
      height: height,
      fontSize: fontSize,
      color: colorFont,
      fontWeight: fontWeight,
    ),
  );
}
