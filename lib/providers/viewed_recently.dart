import 'package:e_commerce/models/viewed_recently.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ViewedProvider extends ChangeNotifier {
  final Map<String, ViewedRecentlyModel> _viewedRecentlyItems = {};

  Map<String, ViewedRecentlyModel> get getViewedItems {
    return _viewedRecentlyItems;
  }

  void viewedRecentlyProduct({required String productId}) {
    _viewedRecentlyItems.putIfAbsent(
      productId,
      () => ViewedRecentlyModel(
        viewedRecentlyId: const Uuid().v4(),
        productId: productId,
      ),
    );
    notifyListeners();
  }

  void clearAllViewed() {
    _viewedRecentlyItems.clear();
    notifyListeners();
  }
}
