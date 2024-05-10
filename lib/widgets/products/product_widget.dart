import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/providers/prodcut_provider.dart';
import 'package:e_commerce/screens/inner_screen/product_details.dart';
import 'package:e_commerce/widgets/products/heart_button_widget.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, required this.productId});

  final String productId;
  @override
  Widget build(BuildContext context) {
    // final productModelProvider = Provider.of<ProductModel>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final currentProductId = productProvider.findProductById(productId);
    final cartProvider = Provider.of<CartProvider>(context);

    Size size = MediaQuery.of(context).size;
    return currentProductId == null
        ? const SizedBox.shrink()
        : GestureDetector(
            onTap: () async {
              await Navigator.of(context).pushNamed(
                ProductDetails.routeName,
                arguments: currentProductId.productId,
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: FancyShimmerImage(
                      imageUrl: currentProductId.productImage,
                      width: double.infinity,
                      height: size.height * 0.2,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        flex: 5,
                        child: TitleText(
                          label: currentProductId.productTitle,
                          fontSize: 18,
                          maxLines: 2,
                        ),
                      ),
                      Flexible(
                        child: HeartButtonWidget(
                          productId: currentProductId.productId,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        flex: 3,
                        child: TitleText(
                          label: '\$${currentProductId.productPrice}',
                          color: Colors.blueAccent.shade200,
                          fontSize: 20,
                        ),
                      ),
                      Flexible(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            if (cartProvider.isProductInCart(
                              productId: currentProductId.productId,
                            )) {
                              return;
                            }
                            cartProvider.addProductToCart(
                              productId: currentProductId.productId,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: Colors.lightBlue.shade200,
                            ),
                            child: Icon(
                              cartProvider.isProductInCart(
                                      productId: currentProductId.productId)
                                  ? Icons.check
                                  : Icons.add_shopping_cart_rounded,
                              size: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
