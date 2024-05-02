import 'package:e_commerce/screens/inner_screen/product_details.dart';
import 'package:e_commerce/widgets/products/heart_button_widget.dart';
import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).pushNamed(ProductDetails.routeName);
      },
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: FancyShimmerImage(
                imageUrl: 'https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png',
                width: double.infinity,
                height: size.height * 0.2,
              ),
            ),
            Row(
              children: [
                Flexible(
                  flex: 5,
                  child: TitleText(
                    label: 'label ' * 10,
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
                const Flexible(
                  flex: 3,
                  child: SubtitleText(label: '\$166'),
                ),
                Flexible(
                  child: Material(
                    borderRadius: BorderRadius.circular(18),
                    color: Colors.lightBlue,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () {},
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.add_shopping_cart_rounded,
                          size: 24,
                          color: Colors.white,
                        ),
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
