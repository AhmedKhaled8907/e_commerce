// ignore_for_file: unused_local_variable, avoid_print


import 'package:flutter/material.dart';

import 'widgets/register_body.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/RegisterScreen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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






