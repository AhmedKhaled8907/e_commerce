import 'package:e_commerce/consts/my_validators.dart';
import 'package:flutter/material.dart';

class RegisterEmailTextForm extends StatelessWidget {
  const RegisterEmailTextForm({
    super.key,
    required this.emailController,
    required FocusNode emailFocusNode,
    required FocusNode passwordFocusNode,
  })  : _emailFocusNode = emailFocusNode,
        _passwordFocusNode = passwordFocusNode;

  final TextEditingController emailController;
  final FocusNode _emailFocusNode;
  final FocusNode _passwordFocusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      focusNode: _emailFocusNode,
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
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      },
    );
  }
}
