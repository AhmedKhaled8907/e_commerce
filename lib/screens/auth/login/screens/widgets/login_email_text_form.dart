import 'package:flutter/material.dart';

import '../../../../../consts/my_validators.dart';

class LogInEmailTextForm extends StatelessWidget {
  const LogInEmailTextForm({
    super.key,
    required this.emailController,
    required this.emailFocusNode,
    required this.passwordFocusNode,
  });

  final TextEditingController? emailController;
  final FocusNode emailFocusNode;
  final FocusNode passwordFocusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      focusNode: emailFocusNode,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.email_outlined),
        hintText: 'Email Address',
      ),
      validator: (value) {
        return MyValidators.emailValidator(value);
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(passwordFocusNode);
      },
    );
  }
}
