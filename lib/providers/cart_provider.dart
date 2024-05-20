import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/providers/prodcut_provider.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class CartProvider extends ChangeNotifier {
  final Map<String, CartModel> _cartItems = {};

  Map<String, CartModel> get getCarts {
    return _cartItems;
  }

  bool isProductInCart({required String productId}) {
    return _cartItems.containsKey(productId);
  }

  void addProductToCart({required String productId}) {
    _cartItems.putIfAbsent(
      productId,
      () => CartModel(
        cartId: const Uuid().v4(),
        productId: productId,
        quantity: 1,
      ),
    );
    notifyListeners();
  }

  void updateQuantity({required String productId, required int quantity}) {
    _cartItems.update(
      productId,
      (item) => CartModel(
        cartId: item.cartId,
        productId: productId,
        quantity: quantity,
      ),
    );
    notifyListeners();
  }

  void removeProductFromCart({required String productId}) {
    _cartItems.remove(productId);
    notifyListeners();
  }

  void clearAllCart() {
    _cartItems.clear();
    notifyListeners();
  }

  double getTotal({required ProductProvider productProvider}) {
    double total = 0.0;
    _cartItems.forEach((key, value) {
      final getCurrentProduct =
          productProvider.findProductById(value.productId);
      if (getCurrentProduct == null) {
        total += 0.0;
      } else {
        total += double.parse(getCurrentProduct.productPrice) * value.quantity;
      }
    });
    return total;
  }

  int getTotalQuantity() {
    int total = 0;
    _cartItems.forEach((key, value) {total += value.quantity;});
    return total;
  }
}
