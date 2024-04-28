import 'package:e_commerce/consts/assets.dart';
import 'package:e_commerce/widgets/custom_empty_bag.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: CustomEmptyBag(
        imagePath: Assets.imagesBagShoppingBasket,
        title: 'Your Cart Is Empty',
        subtitle:
            'Looks like you didn\'t add anything to your cart .Go ahead and explore Top Categorires',
      ),
    );
  }
}
