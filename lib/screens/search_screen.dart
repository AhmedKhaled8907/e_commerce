import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:e_commerce/consts/assets.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/providers/prodcut_provider.dart';
import 'package:e_commerce/widgets/products/product_widget.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static const routeName = '/SearchScreen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchController;
  List<ProductModel> searchList = [];

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
    String? selectedCategory =
        ModalRoute.of(context)!.settings.arguments as String?;
    final List<ProductModel> productsList = selectedCategory == null
        ? productProvider.getProducts
        : productProvider.findProductByCategory(selectedCategory);

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
          title: TitleText(label: selectedCategory ?? 'Search'),
        ),
        body: StreamBuilder<List<ProductModel>>(
            stream: productProvider.fetchProductsAsStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.hasError) {
                return Center(
                  child: TitleText(label: snapshot.error.toString()),
                );
              }
              if (snapshot.data == null) {
                return const Center(
                  child: TitleText(label: 'No products found'),
                );
              }
              if (snapshot.hasData) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: 'Search',
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
                        onChanged: (value) {
                          // setState(() {   searchList = productProvider.searchQuery(
                          //     searchText: searchController.text,
                          //     selectedList: productsList,
                          //   );
                          // });
                        },
                        onSubmitted: (value) {
                          setState(() {
                            searchList = productProvider.searchQuery(
                              searchText: searchController.text,
                              selectedList: productsList,
                            );
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      if (searchController.text.isNotEmpty &&
                          searchList.isEmpty) ...[
                        const Center(
                          child: TitleText(
                            label: 'No results found',
                            fontSize: 32,
                          ),
                        ),
                      ],
                      Expanded(
                        child: DynamicHeightGridView(
                          itemCount: searchController.text.isNotEmpty
                              ? searchList.length
                              : productsList.length,
                          crossAxisCount: 2,
                          builder: (context, index) {
                            return ProductWidget(
                              productId: searchController.text.isNotEmpty
                                  ? searchList[index].productId
                                  : productsList[index].productId,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            }),
      ),
    );
  }
}
