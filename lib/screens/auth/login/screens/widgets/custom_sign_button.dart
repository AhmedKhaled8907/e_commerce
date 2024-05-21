import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';

class CustomSignButton extends StatelessWidget {
  const CustomSignButton({
    super.key,
    required this.onPressed,
  });

  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent.shade700,
          padding: const EdgeInsets.symmetric(
            vertical: 8,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: const TitleText(
          label: 'Sign In',
          color: Colors.white,
          fontSize: 24,
        ),
      ),
    );
  }
}
