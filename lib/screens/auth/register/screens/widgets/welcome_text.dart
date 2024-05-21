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
        TitleText(
          label: 'Hi There, Welcome',
          fontSize: 26,
        ),
        SizedBox(height: 4),
        SubtitleText(
          label:
              'Sign up now to receive special offers and updates from our app.',
          fontSize: 14,
        ),
      ],
    );
  }
}
