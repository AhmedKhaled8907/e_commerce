import 'package:e_commerce/consts/my_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class RegisterRepeatPasswordTextForm extends StatefulWidget {
  const RegisterRepeatPasswordTextForm({
    super.key,
    required this.repeatPasswordController,
    required this.repeatPasswordFocusNode,
    required this.passwordController,
    required this.onFieldSubmitted,
  });

  final TextEditingController repeatPasswordController;
  final FocusNode repeatPasswordFocusNode;
  final TextEditingController passwordController;
  final void Function(String)? onFieldSubmitted;

  @override
  State<RegisterRepeatPasswordTextForm> createState() =>
      _RegisterRepeatPasswordTextFormState();
}

class _RegisterRepeatPasswordTextFormState
    extends State<RegisterRepeatPasswordTextForm> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.repeatPasswordController,
      focusNode: widget.repeatPasswordFocusNode,
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.visiblePassword,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: const Icon(IconlyLight.password),
        hintText: 'Repeat Password',
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
          return MyValidators.repeatPasswordValidator(
            value: value,
            password: widget.passwordController.text,
          );
        }
        return null;
      },
      onFieldSubmitted: (value) {
        widget.onFieldSubmitted;

        // await _registerUser();
      },
    );
  }
}

