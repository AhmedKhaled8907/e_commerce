import 'package:flutter/material.dart';

class CartModel with ChangeNotifier {
  final String cardId, productId;
  final int quantity;

  CartModel({
    required this.cardId,
    required this.productId,
    required this.quantity,
  });
}
