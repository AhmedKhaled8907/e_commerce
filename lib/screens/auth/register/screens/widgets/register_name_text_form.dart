import 'package:e_commerce/consts/my_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class RegisterNameTextForm extends StatelessWidget {
  const RegisterNameTextForm({
    super.key,
    required this.nameController,
    required FocusNode nameFocusNode,
    required FocusNode emailFocusNode,
  })  : _nameFocusNode = nameFocusNode,
        _emailFocusNode = emailFocusNode;

  final TextEditingController nameController;
  final FocusNode _nameFocusNode;
  final FocusNode _emailFocusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nameController,
      focusNode: _nameFocusNode,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      decoration: const InputDecoration(
        prefixIcon: Icon(IconlyLight.message),
        hintText: 'Full Name',
      ),
      validator: (value) {
        return MyValidators.displayNameValidator(value);
      },
      onFieldSubmitted: (value) {
        FocusScope.of(context).requestFocus(_emailFocusNode);
      },
    );
  }
}

