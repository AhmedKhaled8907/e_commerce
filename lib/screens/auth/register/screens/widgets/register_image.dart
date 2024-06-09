import 'package:e_commerce/providers/register_provider.dart';
import 'package:e_commerce/services/my_app_services.dart';
import 'package:e_commerce/widgets/auth/pick_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class RegisterImage extends StatefulWidget {
  const RegisterImage({super.key});

  @override
  State<RegisterImage> createState() => _RegisterImageState();
}

class _RegisterImageState extends State<RegisterImage> {
  Future<XFile?> localImagePicker() async {
    final ImagePicker picker = ImagePicker();
    await MyAppServices.showImagePickerDialog(
      context: context,
      onPressedCamera: () async {
        XFile? pickedImage = await picker.pickImage(source: ImageSource.camera);
        if (mounted) {
          Provider.of<RegisterProvider>(context, listen: false)
              .setPickedImage(pickedImage);
        }
      },
      onPressedGallery: () async {
        XFile? pickedImage =
            await picker.pickImage(source: ImageSource.gallery);
        if (mounted) {
          Provider.of<RegisterProvider>(context, listen: false)
              .setPickedImage(pickedImage);
        }
      },
      onPressedRemove: () {
        Provider.of<RegisterProvider>(context, listen: false)
            .setPickedImage(null);
      },
    );
    return null;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: SizedBox(
        height: size.width * 0.3,
        width: size.width * 0.3,
        child: Consumer<RegisterProvider>(builder: (context, provider, child) {
          return PickImage(
            pickedImage: provider.getPickedImage,
            onTap: () async {
              await localImagePicker();
            },
          );
        }),
      ),
    );
  }
}
