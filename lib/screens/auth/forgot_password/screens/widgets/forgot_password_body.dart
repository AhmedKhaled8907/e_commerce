import 'package:flutter/material.dart';

import 'forgot_password_form.dart';
import 'forgot_password_image.dart';
import 'request_link_button.dart';
import 'texts_section.dart';

class ForgotPasswordBody extends StatelessWidget {
  const ForgotPasswordBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 48),
              ForgotPasswordImage(),
              SizedBox(height: 48),
              TextsSection(),
              SizedBox(height: 48),
              ForgotPasswordForm(),
              SizedBox(height: 36),
              RequestLinkButton(),
            ],
          ),
        ),
      ),
    );
  }
}
