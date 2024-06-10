import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_admin/services/my_app_method.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class ProductUtils {
  static Future<void> uploadProduct({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required TextEditingController titleController,
    required TextEditingController priceController,
    required TextEditingController descriptionController,
    required TextEditingController quantityController,
    required String? categoryValue,
    required XFile? pickedImage,
    required Function setStateCallback,
    required Function clearFormCallback,
  }) async {
    final isValid = formKey.currentState!.validate();

    if (categoryValue == null) {
      MyAppMethods.showErrorORWarningDialog(
        context: context,
        subtitle: "Please select a Category.",
        fct: () {},
      );
      return;
    }

    if (pickedImage == null) {
      MyAppMethods.showErrorORWarningDialog(
        context: context,
        subtitle: "Please pick up an image",
        fct: () {},
      );
      return;
    }

    if (isValid) {
      formKey.currentState!.save();
      FocusScope.of(context).unfocus();

      try {
        setStateCallback(() {});

        final storageRef = FirebaseStorage.instance
            .ref()
            .child('productsImages')
            .child('${titleController.text.trim()}.jpg');
        await storageRef.putFile(File(pickedImage.path));
        final productImageUrl = await storageRef.getDownloadURL();

        final productId = const Uuid().v4();

        await FirebaseFirestore.instance
            .collection('products')
            .doc(productId)
            .set({
          'productId': productId,
          'productTitle': titleController.text,
          'productPrice': priceController.text,
          'productImage': productImageUrl,
          'productCategory': categoryValue,
          'productQuantity': quantityController.text,
          'productDescription': descriptionController.text,
          'createdAt': Timestamp.now(),
        });

        Fluttertoast.showToast(
          msg: "Product has been added",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
        );
        clearFormCallback();
      } on FirebaseException catch (error) {
        if (context.mounted) {
          await MyAppMethods.showErrorORWarningDialog(
            context: context,
            subtitle: "An error has been occurred ${error.message}",
            fct: () {},
          );
        }
      } catch (error) {
        if (context.mounted) {
          await MyAppMethods.showErrorORWarningDialog(
            context: context,
            subtitle: "An error has been occurred $error",
            fct: () {},
          );
        }
      } finally {
        setStateCallback(() {});
      }
    }
  }

  static Future<void> editProduct({
    required BuildContext context,
    required GlobalKey<FormState> formKey,
    required XFile? pickedImage,
    required String? productNetworkImage,
    required TextEditingController titleController,
    required TextEditingController priceController,
    required TextEditingController descriptionController,
    required TextEditingController quantityController,
    required String? categoryValue,
    required Function setStateCallback,
  }) async {
    final isValid = formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (pickedImage == null && productNetworkImage == null) {
      MyAppMethods.showErrorORWarningDialog(
        context: context,
        subtitle: "Please pick up an image",
        fct: () {},
      );
      return;
    }
    if (isValid) {
      // Implement the edit product functionality
    }
  }

  static Future<void> localImagePicker({
    required BuildContext context,
    required Function(XFile?) setPickedImageCallback,
  }) async {
    final ImagePicker picker = ImagePicker();
    await MyAppMethods.imagePickerDialog(
      context: context,
      cameraFCT: () async {
        final pickedImage = await picker.pickImage(source: ImageSource.camera);
        setPickedImageCallback(pickedImage);
      },
      galleryFCT: () async {
        final pickedImage = await picker.pickImage(source: ImageSource.gallery);
        setPickedImageCallback(pickedImage);
      },
      removeFCT: () {
        setPickedImageCallback(null);
      },
    );
  }
}
