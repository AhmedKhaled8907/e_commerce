import 'package:e_commerce/screens/auth/login/screens/widgets/guest_button.dart';
import 'package:e_commerce/widgets/auth/google_button.dart';
import 'package:flutter/material.dart';

class ConnectionSection extends StatelessWidget {
  const ConnectionSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          flex: 2,
          child: GoogleButton(),
        ),
        SizedBox(width: 16),
        GuestButton(),
      ],
    );
  }
}
