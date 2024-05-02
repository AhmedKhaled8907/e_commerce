import 'package:e_commerce/screens/cart/quantity_bottom_sheet.dart';
import 'package:e_commerce/widgets/products/heart_button_widget.dart';
import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class CartBody extends StatelessWidget {
  const CartBody({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FittedBox(
      child: IntrinsicWidth(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FancyShimmerImage(
                  imageUrl:
                      'https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png',
                  width: size.height * 0.2,
                  height: size.height * 0.2,
                ),
              ),
              const SizedBox(width: 16),
              IntrinsicWidth(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IntrinsicWidth(
                          child: SizedBox(
                            width: size.width * 0.6,
                            child: TitleText(
                              label: 'label ' * 10,
                              maxLines: 2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.clear),
                            ),
                            const HeartButtonWidget(),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SubtitleText(
                          label: '\$20',
                          fontSize: 24,
                          color: Colors.blueAccent.shade400,
                          fontWeight: FontWeight.w500,
                        ),
                        OutlinedButton.icon(
                          onPressed: () async {
                            await showModalBottomSheet(
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              useSafeArea: true,
                              elevation: 0,
                              context: context,
                              builder: (context) => const QuantityBottomSheet(),
                            );
                          },
                          icon: const Icon(IconlyLight.arrowDown2),
                          label: SubtitleText(
                            label: 'Qty 5',
                            fontSize: 20,
                            color: Colors.blueAccent.shade400,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
