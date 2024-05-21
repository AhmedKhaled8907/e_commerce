import 'package:e_commerce/screens/root_screen.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';

class GuestButton extends StatelessWidget {
  const GuestButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueGrey,
          padding: const EdgeInsets.symmetric(vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pushReplacementNamed(
            RootScreen.routeName,
          );
        },
        child: const TitleText(
          label: 'Guest?',
          color: Colors.white,
        ),
      ),
    );
  }
}
