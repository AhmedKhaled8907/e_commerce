import 'package:e_commerce/consts/assets.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/screens/cart/cart_body.dart';
import 'package:e_commerce/screens/cart/cart_bottom_checkout.dart';
import 'package:e_commerce/services/my_app_services.dart';
import 'package:e_commerce/widgets/custom_empty_bag.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required this.isEmpty});

  final bool isEmpty;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return cartProvider.getCarts.isEmpty
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
              title: TitleText(
                label: 'Cart (${cartProvider.getCarts.length})',
                fontSize: 24,
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    MyAppServices.showErrorOrWarningDialog(
                        context: context,
                        subtitle: 'Remove Items',
                        onPressed: () {
                          cartProvider.clearAllCart();
                        });
                  },
                  icon: const Icon(Icons.delete_forever_rounded),
                ),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: cartProvider.getCarts.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                          value: cartProvider.getCarts.values
                              .toList()
                              .reversed
                              .toList()[index],
                          child: const CartBody(),
                        );
                      }),
                ),
                // const SizedBox(height: kBottomNavigationBarHeight + 10),
                const CartBottomCheckout(),
              ],
            ),
          );
  }
}
