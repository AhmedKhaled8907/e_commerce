import 'package:e_commerce/consts/assets.dart';
import 'package:e_commerce/models/categories_model.dart';

class AppConstants {
  static String productImage =
      'https://i.ibb.co/8r1Ny2n/20-Nike-Air-Force-1-07.png';

  static List<String> bannersImages = [
    Assets.imagesBannersBanner1,
    Assets.imagesBannersBanner2,
  ];

  static List<CategoriesModel> categories = [
  CategoriesModel(
    imagePath: Assets.imagesCategoriesMobiles,
    title: 'Phones',
  ),
  CategoriesModel(
    imagePath: Assets.imagesCategoriesPc,
    title: 'Laptops',
  ),
  CategoriesModel(
    imagePath: Assets.imagesCategoriesElectronics,
    title: 'Electronics',
  ),
  CategoriesModel(
    imagePath: Assets.imagesCategoriesWatch,
    title: 'Watches',
  ),
  CategoriesModel(
    imagePath: Assets.imagesCategoriesFashion,
    title: 'Clothes',
  ),
  CategoriesModel(
    imagePath: Assets.imagesCategoriesShoes,
    title: 'Shoes',
  ),
  CategoriesModel(
    imagePath: Assets.imagesCategoriesBookImg,
    title: 'Books',
  ),
  CategoriesModel(
    imagePath: Assets.imagesCategoriesCosmetics,
    title: 'Cosmetics',
  ),
];

}
