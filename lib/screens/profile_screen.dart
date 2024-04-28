import 'package:e_commerce/consts/assets.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: Image.asset(Assets.imagesBagShoppingCart),
        title: const Text('SmartShop'),
      ),
      body: const Center(
        child: TitleText(label: 'Profile Screen'),
      ),
    );
  }
}
