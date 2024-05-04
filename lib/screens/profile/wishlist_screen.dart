import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:e_commerce/widgets/products/product_widget.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = '/WishlistScreen';

  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(context),
      body: DynamicHeightGridView(
        itemCount: 20,
        crossAxisCount: 2,
        builder: (context, index) {
          return const ProductWidget(productId: '',);
        },
      ),
    );
  }

  AppBar buildAppbar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: const TitleText(
        label: 'Wishlist (5)',
        fontSize: 24,
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.delete_forever_rounded),
        ),
      ],
    );
  }
}
