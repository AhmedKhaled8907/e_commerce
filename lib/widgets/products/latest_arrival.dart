import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/providers/cart_provider.dart';
import 'package:e_commerce/providers/prodcut_provider.dart';
import 'package:e_commerce/screens/inner_screen/product_details.dart';
import 'package:e_commerce/widgets/products/heart_button_widget.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LatestArrival extends StatelessWidget {
  const LatestArrival({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productModel = Provider.of<ProductModel>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final currentProductId = productProvider.findProductById(productId);
    final cartProvider = Provider.of<CartProvider>(context);

    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).pushNamed(ProductDetails.routeName);
      },
      child: SizedBox(
        width: size.width * 0.5,
        child: Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: FancyShimmerImage(
                    imageUrl: productModel.productImage,
                    width: size.width * 0.3,
                    height: size.width * 0.3,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      style: const TextStyle(fontSize: 16),
                      productModel.productTitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HeartButtonWidget(
                          productId: productModel.productId,
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
                                  productId: currentProductId!.productId,
                                )
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
                    FittedBox(
                      child: TitleText(
                        label: '\$${productModel.productPrice}',
                        color: Colors.blueAccent.shade700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
