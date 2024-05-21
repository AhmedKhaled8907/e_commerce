import 'package:e_commerce/consts/my_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class RegisterPasswordTextForm extends StatefulWidget {
  const RegisterPasswordTextForm({
    super.key,
    required this.passwordController,
    required this.passwordFocusNode,
    required this.repeatPasswordFocusNode,
  });

  final TextEditingController passwordController;
  final FocusNode passwordFocusNode;
  final FocusNode repeatPasswordFocusNode;

  @override
  State<RegisterPasswordTextForm> createState() =>
      _RegisterPasswordTextFormState();
}

class _RegisterPasswordTextFormState extends State<RegisterPasswordTextForm> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.passwordController,
      focusNode: widget.passwordFocusNode,
      textInputAction: TextInputAction.next,
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
        FocusScope.of(context).requestFocus(widget.repeatPasswordFocusNode);
      },
    );
  }
}

