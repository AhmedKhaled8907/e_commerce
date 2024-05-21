import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';

class SignInTextWidget extends StatelessWidget {
  const SignInTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TitleText(
                label: 'Have an account already? ',
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const TitleText(
                  label: 'Sign In',
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
