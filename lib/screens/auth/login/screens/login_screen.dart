// ignore_for_file: avoid_print

import 'package:e_commerce/screens/auth/login/screens/widgets/custom_sign_up_text.dart';
import 'package:e_commerce/screens/auth/login/screens/widgets/login_form.dart';
import 'package:e_commerce/screens/auth/login/screens/widgets/connection_section.dart';
import 'package:e_commerce/widgets/custom_circular_indicator.dart';
import 'package:flutter/material.dart';

import '../../../../widgets/app_name_text.dart';
import '../../../../widgets/subtitle_text.dart';
import 'widgets/welcome_text.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginBody(),
    );
  }
}

class LoginBody extends StatefulWidget {
  const LoginBody({super.key});

  @override
  State<LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<LoginBody> {
  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: _isLoading
          ? const CustomCircularIndicator()
          : const CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 64,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: AppNameText(fontSize: 32),
                        ),
                        WelcomeText(),
                        SizedBox(height: 48),
                        LogInForm(),
                        SizedBox(height: 32),
                        Center(
                          child: SubtitleText(
                            label: 'OR CONNECT USING',
                          ),
                        ),
                        SizedBox(height: 32),
                        ConnectionSection(),
                      ],
                    ),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: CustomSignUpText(),
                ),
              ],
            ),
    );
  }
}
