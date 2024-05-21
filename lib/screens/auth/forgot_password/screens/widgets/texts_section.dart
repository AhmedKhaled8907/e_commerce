import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';

import '../../../../../widgets/subtitle_text.dart';

class TextsSection extends StatelessWidget {
  const TextsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(
          label: 'Forgot password',
          fontSize: 22,
        ),
        SizedBox(height: 16),
        SubtitleText(
          label:
              'Please enter the email address you\'d like your password reset information sent to',
          fontSize: 14,
        ),
      ],
    );
  }
}

