import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:e_commerce/consts/assets.dart';
import 'package:e_commerce/providers/prodcut_provider.dart';
import 'package:e_commerce/widgets/products/product_widget.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchController;

  @override
  void initState() {
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Image.asset(Assets.imagesBagShoppingCart),
          ),
          title: const TitleText(label: 'Search'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.blueAccent.shade700,
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      searchController.clear();
                      FocusScope.of(context).unfocus();
                    },
                    child: Icon(
                      Icons.clear,
                      color: Colors.blueAccent.shade700,
                    ),
                  ),
                ),
                onChanged: (value) {},
                onSubmitted: (value) {},
              ),
              const SizedBox(height: 24),
              Expanded(
                child: DynamicHeightGridView(
                  itemCount: productProvider.getProducts.length,
                  crossAxisCount: 2,
                  builder: (context, index) {
                    return ChangeNotifierProvider.value(
                      value: productProvider.getProducts[index],
                      child: const ProductWidget(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
