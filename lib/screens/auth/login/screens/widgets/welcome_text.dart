import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 64),
        TitleText(
          label: 'Welcome Back',
          fontSize: 26,
        ),
        SubtitleText(
          label: 'Let\'s get you logged in so you can start exploring.',
          fontSize: 14,
        ),
      ],
    );
  }
}
