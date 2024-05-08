import 'dart:developer';

import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class QuantityBottomSheet extends StatelessWidget {
  const QuantityBottomSheet({super.key, required this.cartModel});

  final CartModel cartModel;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            width: 50,
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade300,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: 30,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    cartProvider.updateQuantity(
                      productId: cartModel.productId,
                      quantity: index + 1,
                    );
                    Navigator.of(context).pop();
                    log((index + 1).toString());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Center(
                      child: SubtitleText(
                        label: (index + 1).toString(),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
