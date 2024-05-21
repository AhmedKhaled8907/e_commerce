// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:e_commerce/screens/auth/register/screens/widgets/register_email_text_form.dart';
import 'package:e_commerce/screens/root_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'register_name_text_form.dart';
import 'register_password_text_form.dart';
import 'register_repeat_password_text_form.dart';
import 'sign_up_button.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController repeatPasswordController;
  late FocusNode _nameFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  late FocusNode _repeatPasswordFocusNode;
  late final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  void initState() {
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    repeatPasswordController = TextEditingController();
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _repeatPasswordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    repeatPasswordController.dispose();
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _repeatPasswordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _registerUser() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      FocusScope.of(context).unfocus();

      try {
        setState(() {
          isLoading = true;
        });
        await _auth.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        if (mounted) {
          Navigator.of(context).pushReplacementNamed(RootScreen.routeName);
        }

        isLoading = false;
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });
        log(e.toString());

        if (e.code == 'weak-password') {
          log(e.toString());
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          setState(() {
            isLoading = false;
          });
          log(e.toString());
          Fluttertoast.showToast(
            msg: "The account already exists for that email.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          // print('The account already exists for that email.');
        }
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        log(e.toString());
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }

    // if (isValid) {
    //   if (_pickedImage == null) {
    //     MyAppServices.showErrorOrWarningDialog(
    //       context: context,
    //       subtitle: 'Please pick an image',
    //       onPressed: () {},
    //     );
    //   }
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          RegisterNameTextForm(
            nameController: nameController,
            nameFocusNode: _nameFocusNode,
            emailFocusNode: _emailFocusNode,
          ),
          const SizedBox(height: 16),
          RegisterEmailTextForm(
            emailController: emailController,
            emailFocusNode: _emailFocusNode,
            passwordFocusNode: _passwordFocusNode,
          ),
          const SizedBox(height: 16),
          RegisterPasswordTextForm(
            passwordController: passwordController,
            passwordFocusNode: _passwordFocusNode,
            repeatPasswordFocusNode: _repeatPasswordFocusNode,
          ),
          const SizedBox(height: 16),
          RegisterRepeatPasswordTextForm(
            repeatPasswordController: repeatPasswordController,
            repeatPasswordFocusNode: _repeatPasswordFocusNode,
            passwordController: passwordController,
            onFieldSubmitted: (p0) async {
              // await _registerUser();
            },
          ),
          const SizedBox(height: 32),
          SignUpButton(
            onPressed: () async {
              await _registerUser();
            },
          ),
        ],
      ),
    );
  }
}
