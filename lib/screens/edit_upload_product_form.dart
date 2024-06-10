import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:e_commerce_admin/consts/loading_manager.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:e_commerce_admin/consts/app_constants.dart';
import 'package:e_commerce_admin/models/product_model.dart';
import 'package:e_commerce_admin/services/my_app_method.dart';
import 'package:e_commerce_admin/widgets/subtitle_text.dart';
import 'package:uuid/uuid.dart';

import '../consts/my_validators.dart';
import '../widgets/title_text.dart';

class EditOrUploadProductScreen extends StatefulWidget {
  static const routeName = '/EditOrUploadProductScreen';

  const EditOrUploadProductScreen({
    super.key,
    this.productModel,
  });

  final ProductModel? productModel;

  @override
  State<EditOrUploadProductScreen> createState() =>
      _EditOrUploadProductScreenState();
}

class _EditOrUploadProductScreenState extends State<EditOrUploadProductScreen> {
  final _formKey = GlobalKey<FormState>();
  XFile? _pickedImage;
  bool isEditing = false;
  String? productNetworkImage;

  late TextEditingController _titleController,
      _priceController,
      _descriptionController,
      _quantityController;
  String? _categoryValue;
  bool isLoading = false;
  String? productImageUrl;

  @override
  void initState() {
    if (widget.productModel != null) {
      isEditing = true;
      productNetworkImage = widget.productModel!.productImage;
      _categoryValue = widget.productModel!.productCategory;
    }
    _titleController =
        TextEditingController(text: widget.productModel?.productTitle);
    _priceController =
        TextEditingController(text: widget.productModel?.productPrice);
    _descriptionController =
        TextEditingController(text: widget.productModel?.productDescription);
    _quantityController =
        TextEditingController(text: widget.productModel?.productQuantity);
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void clearForm() {
    _titleController.clear();
    _priceController.clear();
    _descriptionController.clear();
    _quantityController.clear();
    _categoryValue = null;
    removePickedImage();
  }

  void removePickedImage() {
    setState(() {
      _pickedImage = null;
      productNetworkImage = null;
    });
  }

  Future<void> _uploadProduct() async {
    final isValid = _formKey.currentState!.validate();

    if (_categoryValue == null) {
      MyAppMethods.showErrorORWarningDialog(
        context: context,
        subtitle: "Please select a Category.",
        fct: () {},
      );
      return;
    }

    if (_pickedImage == null) {
      MyAppMethods.showErrorORWarningDialog(
        context: context,
        subtitle: "Please pick up an image",
        fct: () {},
      );
      return;
    }

    if (isValid) {
      _formKey.currentState!.save();
      FocusScope.of(context).unfocus();

      try {
        setState(() {
          isLoading = true;
        });

        final storageRef = FirebaseStorage.instance
            .ref()
            .child('productsImages')
            .child('${_titleController.text.trim()}.jpg');
        await storageRef.putFile(File(_pickedImage!.path));
        productImageUrl = await storageRef.getDownloadURL();

        final productId = const Uuid().v4();

        await FirebaseFirestore.instance
            .collection('products')
            .doc(productId)
            .set({
          'productId': productId,
          'productTitle': _titleController.text,
          'productPrice': _priceController.text,
          'productImage': productImageUrl,
          'productCategory': _categoryValue,
          'productQuantity': _quantityController.text,
          'productDescription': _descriptionController.text,
          'createdAt': Timestamp.now(),
        });

        Fluttertoast.showToast(
          msg: "Product has been added",
          toastLength: Toast.LENGTH_SHORT,
          textColor: Colors.white,
        );
        clearForm();
      } on FirebaseException catch (error) {
        if (mounted) {
          await MyAppMethods.showErrorORWarningDialog(
            context: context,
            subtitle: "An error has been occurred ${error.message}",
            fct: () {},
          );
        }
      } catch (error) {
        if (mounted) {
          await MyAppMethods.showErrorORWarningDialog(
            context: context,
            subtitle: "An error has been occurred $error",
            fct: () {},
          );
        }
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Future<void> editProduct() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_pickedImage == null && productNetworkImage == null) {
      MyAppMethods.showErrorORWarningDialog(
        context: context,
        subtitle: "Please pick up an image",
        fct: () {},
      );
      return;
    }
    if (isValid) {}
  }

  Future<void> localImagePicker() async {
    final ImagePicker picker = ImagePicker();
    await MyAppMethods.imagePickerDialog(
      context: context,
      cameraFCT: () async {
        _pickedImage = await picker.pickImage(source: ImageSource.camera);
        setState(() {});
      },
      galleryFCT: () async {
        _pickedImage = await picker.pickImage(source: ImageSource.gallery);
        setState(() {});
      },
      removeFCT: () {
        setState(() {
          _pickedImage = null;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoadingManager(
      isLoading: isLoading,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          bottomSheet: BottomActionButtons(
            isEditing: isEditing,
            clearForm: clearForm,
            onUploadOrEdit: () {
              if (isEditing) {
                editProduct();
              } else {
                _uploadProduct();
              }
            },
          ),
          appBar: AppBar(
            centerTitle: true,
            title: const TitlesTextWidget(
              label: "Upload a new product",
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  if (isEditing || productNetworkImage != null)
                    ProductImageWidget(
                      imageUrl: productNetworkImage!,
                    )
                  else if (_pickedImage == null)
                    ImagePickerWidget(
                      onPickImage: localImagePicker,
                    )
                  else
                    ProductImageFileWidget(
                      imageFile: File(_pickedImage!.path),
                    ),
                  if (_pickedImage != null || productNetworkImage != null)
                    ImagePickerButtons(
                      onPickAnother: localImagePicker,
                      onRemove: removePickedImage,
                    ),
                  const SizedBox(height: 25),
                  CategoryDropdown(
                    categoryValue: _categoryValue,
                    onCategoryChanged: (String? value) {
                      setState(() {
                        _categoryValue = value;
                      });
                    },
                  ),
                  const SizedBox(height: 25),
                  ProductForm(
                    formKey: _formKey,
                    titleController: _titleController,
                    priceController: _priceController,
                    descriptionController: _descriptionController,
                    quantityController: _quantityController,
                  ),
                  const SizedBox(height: kBottomNavigationBarHeight + 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class BottomActionButtons extends StatelessWidget {
  final bool isEditing;
  final VoidCallback clearForm;
  final VoidCallback onUploadOrEdit;

  const BottomActionButtons({
    super.key,
    required this.isEditing,
    required this.clearForm,
    required this.onUploadOrEdit,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: kBottomNavigationBarHeight + 10,
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(12),
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(Icons.clear, color: Colors.white),
              label: const Text(
                "Clear",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onPressed: () {
                clearForm();
                FocusScope.of(context).unfocus();
              },
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(12),
                backgroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(Icons.upload, color: Colors.white),
              label: Text(
                isEditing ? "Edit Product" : "Upload Product",
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              onPressed: onUploadOrEdit,
            ),
          ],
        ),
      ),
    );
  }
}

class ProductImageWidget extends StatelessWidget {
  final String imageUrl;

  const ProductImageWidget({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(
        imageUrl,
        height: size.width * 0.5,
        alignment: Alignment.center,
      ),
    );
  }
}

class ImagePickerWidget extends StatelessWidget {
  final VoidCallback onPickImage;

  const ImagePickerWidget({
    super.key,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width * 0.4 + 10,
      height: size.width * 0.4,
      child: DottedBorder(
        color: Colors.blue,
        radius: const Radius.circular(12),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.image_outlined, size: 80, color: Colors.blue),
              TextButton(
                style: TextButton.styleFrom(foregroundColor: Colors.blue),
                onPressed: onPickImage,
                child: const Text("Pick Product image"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductImageFileWidget extends StatelessWidget {
  final File imageFile;

  const ProductImageFileWidget({
    super.key,
    required this.imageFile,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.file(
        imageFile,
        height: size.width * 0.5,
        alignment: Alignment.center,
      ),
    );
  }
}

class ImagePickerButtons extends StatelessWidget {
  final VoidCallback onPickAnother;
  final VoidCallback onRemove;

  const ImagePickerButtons({
    super.key,
    required this.onPickAnother,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: onPickAnother,
          child: const Text("Pick another image",
              style: TextStyle(color: Colors.white)),
        ),
        TextButton(
          onPressed: onRemove,
          child:
              const Text("Remove image", style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}

class CategoryDropdown extends StatelessWidget {
  final String? categoryValue;
  final ValueChanged<String?> onCategoryChanged;

  const CategoryDropdown({
    super.key,
    required this.categoryValue,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: DropdownButtonFormField<String>(
        elevation: 0,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.white, width: 2.0),
          ),
          hintStyle: const TextStyle(color: Colors.white),
        ),
        hint: Text(categoryValue ?? "Select Category"),
        value: categoryValue,
        items: AppConstants.categoriesDropDownList,
        onChanged: onCategoryChanged,
      ),
    );
  }
}

class ProductForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController titleController;
  final TextEditingController priceController;
  final TextEditingController descriptionController;
  final TextEditingController quantityController;

  const ProductForm({
    super.key,
    required this.formKey,
    required this.titleController,
    required this.priceController,
    required this.descriptionController,
    required this.quantityController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              key: const ValueKey('Title'),
              maxLength: 80,
              minLines: 1,
              maxLines: 2,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              decoration: const InputDecoration(hintText: 'Product Title'),
              validator: (value) {
                return MyValidators.uploadProdTexts(
                  value: value,
                  toBeReturnedString: "Please enter a valid title",
                );
              },
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    controller: priceController,
                    key: const ValueKey('Price \$'),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^(\d+)?\.?\d{0,2}')),
                    ],
                    decoration: const InputDecoration(
                      hintText: 'Price',
                      prefix: SubtitleTextWidget(
                        label: "\$ ",
                        color: Colors.blue,
                        fontSize: 16,
                      ),
                    ),
                    validator: (value) {
                      return MyValidators.uploadProdTexts(
                        value: value,
                        toBeReturnedString: "Price is missing",
                      );
                    },
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    key: const ValueKey('Quantity'),
                    decoration: const InputDecoration(hintText: 'Quantity'),
                    validator: (value) {
                      return MyValidators.uploadProdTexts(
                        value: value,
                        toBeReturnedString: "Quantity is missed",
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            TextFormField(
              key: const ValueKey('Description'),
              controller: descriptionController,
              minLines: 5,
              maxLines: 8,
              maxLength: 1000,
              textCapitalization: TextCapitalization.sentences,
              decoration:
                  const InputDecoration(hintText: 'Product description'),
              validator: (value) {
                return MyValidators.uploadProdTexts(
                  value: value,
                  toBeReturnedString: "Description is missed",
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
