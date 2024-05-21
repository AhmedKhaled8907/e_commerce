import 'package:e_commerce/consts/my_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class PasswordLogInForm extends StatefulWidget {
  const PasswordLogInForm({
    super.key,
    required this.passwordController,
    required this.passwordFocusNode,
    required this.onFieldSubmitted,
  });

  final TextEditingController passwordController;
  final FocusNode passwordFocusNode;
  final void Function(String)? onFieldSubmitted;

  @override
  State<PasswordLogInForm> createState() => _PasswordLogInFormState();
}

class _PasswordLogInFormState extends State<PasswordLogInForm> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      focusNode: widget.passwordFocusNode,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: const Icon(IconlyLight.password),
        hintText: 'Password',
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          icon: obscureText
              ? const Icon(Icons.visibility)
              : const Icon(Icons.visibility_off),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return MyValidators.passwordValidator(value);
        }
        return null;
      },
      onFieldSubmitted: (value) {
        widget.onFieldSubmitted;
      },
    );
  }
}
