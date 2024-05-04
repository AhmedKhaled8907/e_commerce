import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/screens/inner_screen/product_details.dart';
import 'package:e_commerce/widgets/products/heart_button_widget.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final productModelProvider = Provider.of<ProductModel>(context);

    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).pushNamed(ProductDetails.routeName);
      },
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: FancyShimmerImage(
                imageUrl: productModelProvider.productImage,
                width: double.infinity,
                height: size.height * 0.2,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 5,
                  child: TitleText(
                    label: productModelProvider.productTitle,
                    fontSize: 18,
                    maxLines: 2,
                  ),
                ),
                const Flexible(
                  child: HeartButtonWidget(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: TitleText(
                    label: '\$${productModelProvider.productPrice}',
                    color: Colors.blueAccent.shade200,
                    fontSize: 20,
                  ),
                ),
                Flexible(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.lightBlue.shade200,
                      ),
                      child: const Icon(
                        Icons.add_shopping_cart_rounded,
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
