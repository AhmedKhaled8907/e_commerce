import 'package:flutter/material.dart';

class ViewedRecentlyModel with ChangeNotifier {
  final String viewedRecentlyId, productId;

  ViewedRecentlyModel({
    required this.viewedRecentlyId,
    required this.productId,
  });
}
