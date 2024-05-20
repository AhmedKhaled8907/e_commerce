// ignore_for_file: avoid_print

import 'dart:developer';

import 'package:e_commerce/consts/my_validators.dart';
import 'package:e_commerce/screens/auth/forgot_password_screen.dart';
import 'package:e_commerce/screens/auth/register_screen.dart';
import 'package:e_commerce/screens/root_screen.dart';
import 'package:e_commerce/widgets/auth/google_button.dart';
import 'package:e_commerce/widgets/custom_circular_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../widgets/app_name_text.dart';
import '../../widgets/subtitle_text.dart';
import '../../widgets/title_text.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/LoginScreen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  late final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  bool obscureText = true;

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
        await _auth.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        if (mounted) {
          Navigator.of(context).pushReplacementNamed(RootScreen.routeName);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          log(e.toString());
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          setState(() {
            _isLoading = false;
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
          _isLoading = false;
        });
        log(e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: _isLoading
            ? const CustomCircularIndicator()
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 64,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Center(
                                child: AppNameText(
                                  fontSize: 32,
                                ),
                              ),
                              const SizedBox(height: 64),
                              const TitleText(
                                label: 'Welcome Back',
                                fontSize: 26,
                              ),
                              const SubtitleText(
                                label:
                                    'Let\'s get you logged in so you can start exploring.',
                                fontSize: 14,
                              ),
                              const SizedBox(height: 48),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: emailController,
                                      focusNode: _emailFocusNode,
                                      textInputAction: TextInputAction.next,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: const InputDecoration(
                                        prefixIcon: Icon(Icons.email_outlined),
                                        hintText: 'Email Address',
                                      ),
                                      validator: (value) {
                                        return MyValidators.emailValidator(
                                            value);
                                      },
                                      onFieldSubmitted: (value) {
                                        FocusScope.of(context)
                                            .requestFocus(_passwordFocusNode);
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    TextFormField(
                                      controller: passwordController,
                                      focusNode: _passwordFocusNode,
                                      textInputAction: TextInputAction.done,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      obscureText: obscureText,
                                      decoration: InputDecoration(
                                        prefixIcon:
                                            const Icon(IconlyLight.password),
                                        hintText: 'Password',
                                        suffixIcon: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              obscureText = !obscureText;
                                            });
                                          },
                                          icon: obscureText
                                              ? const Icon(Icons.visibility)
                                              : const Icon(
                                                  Icons.visibility_off),
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return MyValidators.passwordValidator(
                                              value);
                                        }
                                        return null;
                                      },
                                      onFieldSubmitted: (value) async {
                                        await _loginUser();
                                      },
                                    ),
                                    const SizedBox(height: 24),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: InkWell(
                                        onTap: () async {
                                          await Navigator.of(context).pushNamed(
                                            ForgotPasswordScreen.routeName,
                                          );
                                        },
                                        child: const Text(
                                          'Forgot Password?',
                                          style: TextStyle(
                                            fontSize: 22,
                                            fontStyle: FontStyle.italic,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 48),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.blueAccent.shade700,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ),
                                        onPressed: () async {
                                          await _loginUser();
                                        },
                                        child: const TitleText(
                                          label: 'Sign In',
                                          color: Colors.white,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 32),
                                    const Center(
                                      child: SubtitleText(
                                        label: 'OR CONNECT USING',
                                      ),
                                    ),
                                    const SizedBox(height: 32),
                                    Row(
                                      children: [
                                        const Expanded(
                                          flex: 2,
                                          child: GoogleButton(),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.blueGrey,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                            ),
                                            onPressed: () {},
                                            child: const TitleText(
                                              label: 'Guest?',
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 32),
                      child: Column(
                        children: [
                          const Expanded(child: SizedBox()),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const TitleText(
                                  label: 'Don\'t have an account? '),
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
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
