// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:e_commerce/screens/auth/login/screens/widgets/login_email_text_form.dart';
import 'package:e_commerce/screens/auth/login/screens/widgets/forgot_password_text.dart';
import 'package:e_commerce/screens/root_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'login_password_text_form.dart';
import 'custom_sign_button.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  final _auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loginUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      FocusScope.of(context).unfocus();
      try {
        setState(() {
          isLoading = true;
        });
        await _auth.signInWithEmailAndPassword(
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
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          LogInEmailTextForm(
            emailController: emailController,
            emailFocusNode: _emailFocusNode,
            passwordFocusNode: _passwordFocusNode,
          ),
          const SizedBox(height: 16),
          LogInPasswordTextForm(
            passwordController: passwordController,
            passwordFocusNode: _passwordFocusNode,
            onFieldSubmitted: (value) async {
              await _loginUser();
            },
          ),
          const SizedBox(height: 24),
          const ForgotPasswordText(),
          const SizedBox(height: 48),
          CustomSignButton(
            onPressed: () async {
              await _loginUser();
            },
          ),
        ],
      ),
    );
  }
}
