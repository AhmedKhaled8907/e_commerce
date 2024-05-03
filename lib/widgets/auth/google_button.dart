import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../title_text.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Ionicons.logo_google, color: Colors.white),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey,
        padding: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      label: const TitleText(
        label: 'Login with Google',
        color: Colors.white,
      ),
      onPressed: () {},
    );
  }
}
