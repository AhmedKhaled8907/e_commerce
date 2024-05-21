import 'package:e_commerce/consts/assets.dart';
import 'package:flutter/material.dart';

class ForgotPasswordImage extends StatelessWidget {
  const ForgotPasswordImage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          Assets.imagesForgotPassword,
          width: size.width * 0.65,
          height: size.width * 0.65,
        ),
      ),
    );
  }
}
