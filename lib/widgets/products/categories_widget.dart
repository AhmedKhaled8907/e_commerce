import 'package:e_commerce/models/categories_model.dart';
import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    super.key,
    required this.categoriesModel,
  });

  final CategoriesModel categoriesModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          height: 50,
          width: 50,
          categoriesModel.imagePath,
          fit: BoxFit.fill,
        ),
        const SizedBox(height: 8),
        FittedBox(
          child: SubtitleText(
            label: categoriesModel.title,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
