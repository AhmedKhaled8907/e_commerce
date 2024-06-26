import 'package:card_swiper/card_swiper.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:e_commerce/consts/app_constants.dart';
import 'package:e_commerce/providers/prodcut_provider.dart';
import 'package:e_commerce/widgets/products/categories_widget.dart';
import 'package:e_commerce/widgets/products/latest_arrival.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../consts/assets.dart';
import '../widgets/app_name_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const routeName = '/HomeScreen';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productProvider = Provider.of<ProductProvider>(context);
    final productLength = productProvider.getProducts.length;

    return Scaffold(
      appBar: buildAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const SizedBox(height: 32),
              Visibility(
                visible: productProvider.getProducts.isNotEmpty,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleText(
                      label: 'Latest Arrivals',
                      fontSize: 24,
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: size.height * 0.175,
                      child: ListView.builder(
                        itemCount: productLength < 10 ? productLength : 10,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            ChangeNotifierProvider.value(
                          value: productProvider.getProducts[index],
                          child: LatestArrival(
                            productId:
                                productProvider.getProducts[index].productId,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // const SizedBox(height: 16),
              const TitleText(
                label: 'Categories',
                fontSize: 24,
              ),
              const SizedBox(height: 16),
              DynamicHeightGridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                builder: (context, index) {
                  return GestureDetector(
                    child: CategoriesWidget(
                      categoriesModel: AppConstants.categories[index],
                    ),
                  );
                },
                itemCount: AppConstants.categories.length,
                crossAxisCount: 4,
              ),
            ],
          ),
        ),
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
      title: const AppNameText(),
    );
  }
}
