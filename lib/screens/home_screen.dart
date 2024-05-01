import 'package:card_swiper/card_swiper.dart';
import 'package:e_commerce/consts/app_constants.dart';
import 'package:flutter/material.dart';

import '../consts/assets.dart';
import '../widgets/app_name_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height * 0.24,
            // width: double.infinity,
            child: Swiper(
              itemCount: AppConstants.bannersImages.length,
              itemBuilder: (context, index) {
                return Image.asset(
                  AppConstants.bannersImages[index],
                  fit: BoxFit.fill,
                );
              },
              autoplay: true,
              pagination: const SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Image.asset(Assets.imagesBagShoppingCart),
      ),
      title: const AppNameText(title: 'Smart Shop'),
    );
  }
}
