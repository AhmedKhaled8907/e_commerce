import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/providers/product_provider.dart';
import 'package:e_commerce/widgets/app_name_text.dart';
import 'package:e_commerce/widgets/products/heart_button_widget.dart';
import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatelessWidget {
  static const routeName = '/ProductDetails';
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productProvider =
        Provider.of<ProductProvider>(context, listen: false);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final currentProductId = productProvider.findProductById(productId);

    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: buildAppBar(cartProvider, context),
      body: SingleChildScrollView(
        child: currentProductId == null
            ? const SizedBox.shrink()
            : Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: FancyShimmerImage(
                        boxFit: BoxFit.fill,
                        imageUrl: currentProductId.productImage,
                        width: double.infinity,
                        height: size.height * 0.35,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 3,
                          child: TitleText(
                            label: currentProductId.productTitle,
                            maxLines: 20,
                          ),
                        ),
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: TitleText(
                              label: '\$${currentProductId.productPrice}',
                              fontSize: 24,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          HeartButtonWidget(
                            color: Colors.lightBlue,
                            productId: currentProductId.productId,
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlue.shade100,
                                elevation: 0,
                              ),
                              onPressed: () {
                                cartProvider.addProductToCart(
                                  productId: productId,
                                );
                              },
                              icon: Icon(
                                cartProvider.isProductInCart(
                                        productId: productId)
                                    ? Icons.check
                                    : IconlyLight.bag2,
                                color: Colors.black,
                              ),
                              label: SubtitleText(
                                label: cartProvider.isProductInCart(
                                        productId: productId)
                                    ? 'Already in cart'
                                    : 'Add to cart',
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TitleText(label: 'About this item'),
                        const SizedBox(height: 16),
                        SubtitleText(label: currentProductId.productCategory),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SubtitleText(
                      label: currentProductId.productDescription,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
      ),
    );
  }

  AppBar buildAppBar(CartProvider cartProvider, BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 24),
          child: Badge(
            label: Text('${cartProvider.getCarts.length}'),
            child: const Icon(IconlyLight.bag2),
          ),
        ),
      ],
      title: const AppNameText(),
    );
  }
}
