import 'package:e_commerce/models/wishlist_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class WishlistProvider extends ChangeNotifier {
  final Map<String, WishlistModel> _wishlistItems = {};

  Map<String, WishlistModel> get getWishlists {
    return _wishlistItems;
  }

  bool isProductInWishlist({required String productId}) {
    return _wishlistItems.containsKey(productId);
  }

  void addOrRemoveToWishlist({required String productId}) {
    if (_wishlistItems.containsKey(productId)) {
      _wishlistItems.remove(productId);
    } else {
      _wishlistItems.putIfAbsent(
        productId,
        () => WishlistModel(
          wishlistId: const Uuid().v4(),
          productId: productId,
        ),
      );
    }
    notifyListeners();
  }

  void clearAllWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }
}
