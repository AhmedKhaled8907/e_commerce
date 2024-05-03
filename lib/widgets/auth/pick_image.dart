import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatelessWidget {
  const PickImage({
    super.key,
    this.onTap,
    this.pickedImage,
  });

  final void Function()? onTap;
  final XFile? pickedImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: pickedImage == null
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey),
                    ),
                  )
                : Image.file(
                    File(pickedImage!.path),
                    fit: BoxFit.fill,
                  ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Material(
            borderRadius: BorderRadius.circular(16),
            color: Colors.lightBlue,
            child: InkWell(
              splashColor: Colors.grey,
              borderRadius: BorderRadius.circular(16),
              onTap: onTap,
              child: const Padding(
                padding: EdgeInsets.all(8),
                child: Icon(
                  Icons.shopping_bag_outlined,
                  size: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
