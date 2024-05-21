import 'package:flutter/material.dart';

import '../../../../../widgets/app_name_text.dart';
import '../../../../../widgets/custom_circular_indicator.dart';
import 'register_form.dart';
import 'register_image.dart';
import 'sign_in_text_widget.dart';
import 'welcome_text.dart';

class RegisterBody extends StatefulWidget {
  const RegisterBody({
    super.key,
  });

  @override
  State<RegisterBody> createState() => _RegisterBodyState();
}

class _RegisterBodyState extends State<RegisterBody> {
  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: _isLoading
              ? const CustomCircularIndicator()
              : const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 64),
                      Center(
                        child: AppNameText(fontSize: 32),
                      ),
                      SizedBox(height: 24),
                      WelcomeText(),
                      SizedBox(height: 24),
                      RegisterImage(),
                      SizedBox(height: 36),
                      RegisterForm(),
                    ],
                  ),
                ),
        ),
        const SliverFillRemaining(
          hasScrollBody: false,
          child: SignInTextWidget(),
        ),
      ],
    );
  }
}

