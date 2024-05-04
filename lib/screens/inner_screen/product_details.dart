import 'package:e_commerce/consts/app_constants.dart';
import 'package:e_commerce/widgets/app_name_text.dart';
import 'package:e_commerce/widgets/products/heart_button_widget.dart';
import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class ProductDetails extends StatelessWidget {
  static const routeName = '/ProductDetails';
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: FancyShimmerImage(
                  boxFit: BoxFit.fill,
                  imageUrl: AppConstants.productImage,
                  width: double.infinity,
                  height: size.height * 0.35,
                ),
              ),
              const SizedBox(height: 24),
              const Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: TitleText(
                      label: 'Apple Iphone 12 Pro Max (128GB) - black',
                      maxLines: 2,
                    ),
                  ),
                  Flexible(
                    child: TitleText(
                      label: '\$999.99',
                      fontSize: 24,
                      color: Colors.blueAccent,
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
                    const HeartButtonWidget(
                      color: Colors.lightBlue,
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightBlue.shade100,
                          elevation: 0,
                        ),
                        onPressed: () {},
                        icon: const Icon(
                          IconlyLight.bag2,
                          color: Colors.black,
                        ),
                        label: const SubtitleText(
                          label: 'Add to cart',
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TitleText(label: 'About this item'),
                  SubtitleText(label: 'In Phones'),
                ],
              ),
              const SizedBox(height: 24),
              const SubtitleText(
                label:
                    'The iPhone 12 Pro Max supports wireless charging, as well as proprietary fast charging. As far as the cameras are concerned, the iPhone 12 Pro Max on the rear packs a 12-megapixel (f/1.6) primary camera; a 12-megapixel (f/2.4) camera, and a 12-megapixel (f/2.2) camera. The rear camera setup has autofocus.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 24),
          child: Badge(
            label: Text('5'),
            child: Icon(IconlyLight.bag2),
          ),
        ),
      ],
      title: const AppNameText(),
    );
  }
}
