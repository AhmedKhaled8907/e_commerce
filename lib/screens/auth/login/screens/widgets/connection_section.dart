import 'package:e_commerce/screens/auth/login/screens/widgets/guest_button.dart';
import 'package:e_commerce/widgets/auth/google_button.dart';
import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:flutter/material.dart';

class ConnectionSection extends StatelessWidget {
  const ConnectionSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Center(
          child: SubtitleText(
            label: 'OR CONNECT USING',
          ),
        ),
        SizedBox(height: 32),
        Row(
          children: [
            Expanded(
              flex: 2,
              child: GoogleButton(),
            ),
            SizedBox(width: 16),
            GuestButton(),
          ],
        ),
      ],
    );
  }
}
