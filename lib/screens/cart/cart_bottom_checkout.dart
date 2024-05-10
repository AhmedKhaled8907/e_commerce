import 'package:e_commerce/providers/prodcut_provider.dart';
import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/cart_provider.dart';

class CartBottomCheckout extends StatelessWidget {
  const CartBottomCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          top: BorderSide(
            color: Colors.grey.shade500,
            width: 1.5,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: TitleText(
                    label:
                        'Total (${cartProvider.getCarts.length} products / ${cartProvider.getTotalQuantity()} items)',
                  ),
                ),
                SubtitleText(
                  label:
                      '\$${cartProvider.getTotal(productProvider: productProvider)}',
                  color: Colors.blueAccent.shade700,
                  fontWeight: FontWeight.w500,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent.shade700),
              child: const SubtitleText(
                label: 'Checkout',
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
