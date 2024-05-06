import 'package:e_commerce/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartModel> _carts = {};

  Map<String, CartModel> get getCarts {
    return _carts;
  }

  bool isProductInCart({required String productId}) {
    return _carts.containsKey(productId);
  }

  void addProductToCart({required String productId}) {
    _carts.putIfAbsent(
      productId,
      () => CartModel(
        cardId: const Uuid().v4(),
        productId: productId,
        quantity: 1,
      ),
    );
    notifyListeners();
  }
}
