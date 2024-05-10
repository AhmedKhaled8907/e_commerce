import 'package:e_commerce/providers/wishlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class HeartButtonWidget extends StatelessWidget {
  final Color color;
  final double size;
  final String productId;

  const HeartButtonWidget({
    super.key,
    this.color = Colors.transparent,
    this.size = 24,
    required this.productId,
  });

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);

    return IconButton(
      splashColor: Colors.transparent,
      onPressed: () {
        wishlistProvider.addOrRemoveToWishlist(productId: productId);
      },
      icon: Icon(
        wishlistProvider.isProductInWishlist(productId: productId)
            ? IconlyBold.heart
            : IconlyLight.heart,
        color: wishlistProvider.isProductInWishlist(productId: productId)
            ? Colors.red
            : Colors.white,
        size: size,
      ),
    );
  }
}
