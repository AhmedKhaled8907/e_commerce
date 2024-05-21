import 'package:e_commerce/screens/auth/register/register_screen.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';

class CustomSignUpText extends StatelessWidget {
  const CustomSignUpText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        children: [
          const Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TitleText(
                label: 'Don\'t have an account? ',
              ),
              InkWell(
                onTap: () async {
                  await Navigator.of(context)
                      .pushNamed(RegisterScreen.routeName);
                },
                child: const TitleText(
                  label: 'Sign Up',
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
