import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AppNameText extends StatelessWidget {
  const AppNameText({
    super.key,
    this.fontSize = 24,
    required this.title,
  });

  final double fontSize;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.purple,
      highlightColor: Colors.red,
      period: const Duration(seconds: 10),
      child: TitleText(
        label: title,
        fontSize: fontSize,
      ),
    );
  }
}
