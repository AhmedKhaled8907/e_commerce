import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterProvider extends ChangeNotifier {
  XFile? _pickedImage;

  XFile? get getPickedImage => _pickedImage;

  void setPickedImage(XFile? image) {
    _pickedImage = image;
    notifyListeners();
  }
}
