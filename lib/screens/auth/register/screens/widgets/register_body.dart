import 'package:e_commerce/screens/inner_screen/loading_manager.dart';
import 'package:flutter/material.dart';

import '../../../../../widgets/app_name_text.dart';
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
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return LoadingManager(
      isLoading: isLoading,
      child: const CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  SizedBox(height: 32),
                  Center(
                    child: AppNameText(fontSize: 32),
                  ),
                  SizedBox(height: 48),
                  WelcomeText(),
                  SizedBox(height: 36),
                  RegisterImage(),
                  SizedBox(height: 36),
                  RegisterForm(),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: SignInTextWidget(),
          ),
        ],
      ),
    );
  }
}
