import 'package:e_commerce/services/my_app_services.dart';
import 'package:e_commerce/widgets/auth/pick_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterImage extends StatefulWidget {
  const RegisterImage({super.key});

  @override
  State<RegisterImage> createState() => _RegisterImageState();
}

class _RegisterImageState extends State<RegisterImage> {
  XFile? pickedImage;

  Future<void> _localImagePicker() async {
    final ImagePicker picker = ImagePicker();
    await MyAppServices.showImagePickerDialog(
      context: context,
      onPressedCamera: () async {
        pickedImage = await picker.pickImage(source: ImageSource.camera);
        setState(() {});
      },
      onPressedGallery: () async {
        pickedImage = await picker.pickImage(source: ImageSource.gallery);
        setState(() {});
      },
      onPressedRemove: () {
        setState(() {
          pickedImage = null;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: SizedBox(
        height: size.width * 0.3,
        width: size.width * 0.3,
        child: PickImage(
          pickedImage: pickedImage,
          onTap: () async {
            await _localImagePicker();
          },
        ),
      ),
    );
  }
}
