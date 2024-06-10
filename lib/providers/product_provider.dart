import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/product_model.dart';

class ProductProvider with ChangeNotifier {
    final productDb = FirebaseFirestore.instance.collection('products');
  final List<ProductModel> _products = [];
  
  List<ProductModel> get getProducts {
    return _products;
  }

  ProductModel? findByProdId(String productId) {
    if (_products.where((element) => element.productId == productId).isEmpty) {
      return null;
    }
    return _products.firstWhere((element) => element.productId == productId);
  }

  List<ProductModel> findByCategory({required String ctgName}) {
    List<ProductModel> ctgList = _products
        .where((element) => element.productCategory.toLowerCase().contains(
              ctgName.toLowerCase(),
            ))
        .toList();
    return ctgList;
  }

  List<ProductModel> searchQuery(
      {required String searchText, required List<ProductModel> passedList}) {
    List<ProductModel> searchList = passedList
        .where((element) => element.productTitle.toLowerCase().contains(
              searchText.toLowerCase(),
            ))
        .toList();
    return searchList;
  }

  Future<List<ProductModel>> fetchProducts() async {
    try {
      await productDb
          .orderBy('createdAt', descending: false)
          .get()
          .then((productsSnapshot) {
        _products.clear();
        for (var element in productsSnapshot.docs) {
          _products.insert(
            0,
            ProductModel.fromFirestore(element),
          );
        }
      });
      notifyListeners();
      return _products;
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<ProductModel>> fetchProductsAsStream() {
    try {
      return productDb.snapshots().map((snapshot) {
        _products.clear();
        for (var element in snapshot.docs) {
          _products.insert(
            0,
            ProductModel.fromFirestore(element),
          );
        }
        return _products;
      });
    } catch (e) {
      rethrow;
    }
  }
}
