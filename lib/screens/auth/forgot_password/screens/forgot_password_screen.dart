import 'package:e_commerce/widgets/app_name_text.dart';
import 'package:flutter/material.dart';
import 'widgets/forgot_password_body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static const routeName = '/ForgotPasswordScreen';
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: const SafeArea(
        child: ForgotPasswordBody(),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      centerTitle: true,
      title: const AppNameText(
        fontSize: 24,
      ),
    );
  }
}
