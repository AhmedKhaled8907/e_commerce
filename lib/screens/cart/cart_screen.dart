import 'package:e_commerce/consts/assets.dart';
import 'package:e_commerce/screens/cart/cart_body.dart';
import 'package:e_commerce/widgets/custom_empty_bag.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required this.isEmpty});

  final bool isEmpty;
  @override
  Widget build(BuildContext context) {
    return isEmpty
        ? const Scaffold(
            body: CustomEmptyBag(
              imagePath: Assets.imagesBagShoppingBasket,
              title: 'Your Cart Is Empty',
              subtitle:
                  'Looks like you didn\'t add anything to your cart .Go ahead and explore Top Categorires',
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Image.asset(Assets.imagesBagShoppingCart),
              ),
              title: const TitleText(
                label: 'Cart (5)',
                fontSize: 24,
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.delete_forever_rounded),
                ),
              ],
            ),
            body: ListView.builder(
                itemCount: 15,
                itemBuilder: (context, index) {
                  return const CartBody();
                }),
          );
  }
}
