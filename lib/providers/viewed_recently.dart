import 'package:e_commerce/models/viewed_recently.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ViewedProvider extends ChangeNotifier {
  final Map<String, ViewdRecentlyModel> _viewdRecentlyItems = {};

  Map<String, ViewdRecentlyModel> get getviewedItems {
    return _viewdRecentlyItems;
  }

  void viewedRecentlyProduct({required String productId}) {
    _viewdRecentlyItems.putIfAbsent(
      productId,
      () => ViewdRecentlyModel(
        viewdRecentlyId: const Uuid().v4(),
        productId: productId,
      ),
    );
    notifyListeners();
  }

  void clearAllViewed() {
    _viewdRecentlyItems.clear();
    notifyListeners();
  }
}
