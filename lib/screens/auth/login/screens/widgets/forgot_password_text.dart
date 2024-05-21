import 'package:e_commerce/screens/auth/forgot_password/screens/forgot_password_screen.dart';
import 'package:flutter/material.dart';

class ForgotPasswordText extends StatelessWidget {
  const ForgotPasswordText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWell(
        onTap: () async {
          await Navigator.of(context).pushNamed(
            ForgotPasswordScreen.routeName,
          );
        },
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
            fontSize: 22,
            fontStyle: FontStyle.italic,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    );
  }
}
