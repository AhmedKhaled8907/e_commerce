import 'package:flutter/material.dart';

class SubtitleText extends StatelessWidget {
  const SubtitleText({
    super.key,
    required this.label,
    this.fontSize = 18,
    this.fontStyle = FontStyle.normal,
    this.color,
    this.fontWeight,
    this.textDecoration = TextDecoration.none,
  });

  final String label;
  final double fontSize;
  final FontStyle fontStyle;
  final Color? color;
  final FontWeight? fontWeight;
  final TextDecoration textDecoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        fontSize: fontSize,
        fontStyle: fontStyle,
        color: color,
        fontWeight: fontWeight,
        decoration: textDecoration,
      ),
    );
  }
}
