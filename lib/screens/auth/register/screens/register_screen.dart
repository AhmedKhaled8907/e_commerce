
import 'package:flutter/material.dart';
import 'widgets/register_body.dart';

class RegisterScreen extends StatelessWidget {
  static const routeName = '/RegisterScreen';

  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: const Scaffold(
        body: SafeArea(
          child: RegisterBody(),
        ),
      ),
    );
  }
}






