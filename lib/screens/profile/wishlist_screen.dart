import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:e_commerce/consts/assets.dart';
import 'package:e_commerce/providers/prodcut_provider.dart';
import 'package:e_commerce/providers/wishlist_provider.dart';
import 'package:e_commerce/services/my_app_services.dart';
import 'package:e_commerce/widgets/custom_empty_bag.dart';
import 'package:e_commerce/widgets/products/product_widget.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = '/WishlistScreen';

  const WishlistScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlistItems = wishlistProvider.getWishlists;
    Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: buildAppbar(wishlistProvider, context),
      body: wishlistItems.isEmpty
          ? const CustomEmptyBag(
              imagePath: Assets.imagesBagBagWish,
              title: 'Your Wishlist Is Empty',
              subtitle:
                  'Looks like you didn\'t add anything to your Wishlist .Go ahead and explore Top Categorires',
            )
          : DynamicHeightGridView(
              itemCount: wishlistItems.length,
              crossAxisCount: 2,
              builder: (context, index) {
                return ChangeNotifierProvider.value(
                  value: wishlistItems.values.toList().reversed.toList()[index],
                  child: ProductWidget(
                    productId: wishlistItems.values.toList()[index].productId,
                  ),
                );
              },
            ),
    );
  }

  AppBar buildAppbar(WishlistProvider wishlistProvider, BuildContext context) {
    final wishlistItems = wishlistProvider.getWishlists;
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: TitleText(
        label: 'Wishlist (${wishlistItems.length})',
        fontSize: 24,
      ),
      actions: [
        IconButton(
          onPressed: () {
            if (wishlistItems.isEmpty) {
              return;
            } else {
              MyAppServices.showErrorOrWarningDialog(
                context: context,
                subtitle: 'Remove All Items',
                onPressed: () {
                  wishlistProvider.clearAllWishlist();
                },
              );
            }
          },
          icon: Icon(
            wishlistProvider.getWishlists.isEmpty
                ? null
                : Icons.delete_forever_rounded,
          ),
        ),
      ],
    );
  }
}
