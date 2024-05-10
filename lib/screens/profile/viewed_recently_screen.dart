import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:e_commerce/consts/assets.dart';
import 'package:e_commerce/services/my_app_services.dart';
import 'package:e_commerce/widgets/custom_empty_bag.dart';
import 'package:e_commerce/widgets/products/product_widget.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/viewed_recently.dart';

class ViewdRecently extends StatelessWidget {
  static const routeName = '/ViewdRecently';

  const ViewdRecently({super.key});

  @override
  Widget build(BuildContext context) {
    final viewedProvider = Provider.of<ViewedProvider>(context);

    return Scaffold(
      appBar: buildAppbar(viewedProvider, context),
      body: viewedProvider.getviewedItems.isEmpty
          ? const CustomEmptyBag(
              imagePath: Assets.imagesProfileRecent,
              title: 'Your Wishlist Is Empty',
              subtitle:
                  'Looks like you didn\'t add anything to your Wishlist .Go ahead and explore Top Categorires',
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: DynamicHeightGridView(
                itemCount: viewedProvider.getviewedItems.length,
                crossAxisCount: 2,
                builder: (context, index) {
                  return ProductWidget(
                    productId: viewedProvider.getviewedItems.values
                        .toList()[index]
                        .productId,
                  );
                },
              ),
            ),
    );
  }

  AppBar buildAppbar(ViewedProvider viewedProvider, BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: const TitleText(
        label: 'Viewed Recently',
        fontSize: 24,
      ),
      actions: [
        IconButton(
          onPressed: () {
            MyAppServices.showErrorOrWarningDialog(
              context: context,
              subtitle: 'Remove All Items',
              onPressed: () {
                viewedProvider.clearAllViewed();
              },
            );
          },
          icon: Icon(
            viewedProvider.getviewedItems.isEmpty
                ? null
                : Icons.delete_forever_rounded,
          ),
        ),
      ],
    );
  }
}
