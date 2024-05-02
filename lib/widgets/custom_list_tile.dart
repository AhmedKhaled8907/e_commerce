import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String imagePath;
  final void Function() onTap;

  const CustomListTile({
    super.key,
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minVerticalPadding: 16,
      horizontalTitleGap: 20,
      contentPadding: const EdgeInsets.only(right: 12),
      onTap: onTap,
      leading: Image.asset(
        imagePath,
        height: 46,
      ),
      title: SubtitleText(
        label: title,
        fontWeight: FontWeight.w600,
      ),
      trailing: const Opacity(
        opacity: 0.75,
        child: Icon(
          IconlyLight.arrowRight2,
        ),
      ),
    );
  }
}
