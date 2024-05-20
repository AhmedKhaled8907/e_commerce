import 'package:e_commerce/consts/my_validators.dart';
import 'package:e_commerce/services/my_app_services.dart';
import 'package:e_commerce/widgets/auth/pick_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../widgets/app_name_text.dart';
import '../../widgets/subtitle_text.dart';
import '../../widgets/title_text.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/RegisterScreen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController repeatPasswordController;
  late FocusNode _nameFocusNode;
  late FocusNode _emailFocusNode;
  late FocusNode _passwordFocusNode;
  late FocusNode _repeatPasswordFocusNode;
  late final _formKey = GlobalKey<FormState>();
  bool obscureText = true;
  XFile? _pickedImage;
  bool _isLoading = false;
  final auth = FirebaseAuth.instance;

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

    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      // if (_pickedImage == null) {
      //   MyAppServices.showErrorOrWarningDialog(
      //     context: context,
      //     subtitle: 'Please pick an image',
      //     onPressed: () {},
      //   );
      // }

      try {
        setState(() {
          _isLoading = true;
        });
        await auth.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        Fluttertoast.showToast(
          msg: "An account has been created.",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
        );
      } on FirebaseAuthException catch (e) {
        Fluttertoast.showToast(
          msg: "An Error has occurred ${e.message}",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
        );
      } catch (e) {
        Fluttertoast.showToast(
          msg: "An Error has occurred ${e.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _localImagePicker() async {
    final ImagePicker picker = ImagePicker();
    await MyAppServices.showImagePickerDialog(
      context: context,
      onPressedCamera: () async {
        _pickedImage = await picker.pickImage(source: ImageSource.camera);
        setState(() {});
      },
      onPressedGallery: () async {
        _pickedImage = await picker.pickImage(source: ImageSource.gallery);
        setState(() {});
      },
      onPressedRemove: () {
        setState(() {
          _pickedImage = null;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                      child: AppNameText(
                        fontSize: 32,
                      ),
                    ),
                    const SizedBox(height: 24),
                    const TitleText(
                      label: 'Hi There, Welcome',
                      fontSize: 26,
                    ),
                    const SubtitleText(
                      label:
                          'Sign up now to receive special offers and updates from our app.',
                      fontSize: 14,
                    ),
                    const SizedBox(height: 24),
                    Center(
                      child: SizedBox(
                        height: size.width * 0.3,
                        width: size.width * 0.3,
                        child: PickImage(
                          pickedImage: _pickedImage,
                          onTap: () async {
                            await _localImagePicker();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
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
                              FocusScope.of(context)
                                  .requestFocus(_emailFocusNode);
                            },
                          ),
                          const SizedBox(height: 16),
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
                              return MyValidators.emailValidator(value);
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
                              FocusScope.of(context)
                                  .requestFocus(_repeatPasswordFocusNode);
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: repeatPasswordController,
                            focusNode: _repeatPasswordFocusNode,
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
                                  password: passwordController.text,
                                );
                              }
                              return null;
                            },
                            onFieldSubmitted: (value) async {
                              await _registerUser();
                            },
                          ),
                          const SizedBox(height: 32),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent.shade700,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () async {
                                await _registerUser();
                              },
                              child: const TitleText(
                                label: 'Sign Up',
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
