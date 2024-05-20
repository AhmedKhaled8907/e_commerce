import 'package:e_commerce/consts/assets.dart';
import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';

class MyAppServices {
  static Future<void> showErrorOrWarningDialog({
    required BuildContext context,
    required String subtitle,
    required void Function()? onPressed,
    bool isError = true,
  }) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Image.asset(
              Assets.imagesWarning,
              height: 60,
              width: 60,
            ),
            const SizedBox(height: 24),
            SubtitleText(
              label: subtitle,
              fontSize: 24,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: isError,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const SubtitleText(
                      label: 'Cancel',
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    onPressed!();
                    Navigator.pop(context);
                  },
                  child: const SubtitleText(
                    label: 'OK',
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  static Future<void> showImagePickerDialog({
    required BuildContext context,
    required Function onPressedCamera,
    required Function onPressedGallery,
    required Function onPressedRemove,
  }) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: const Center(child: TitleText(label: 'Choose option')),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {
                  onPressedCamera();
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                icon: const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.camera_alt_rounded,
                    color: Colors.lightBlue,
                  ),
                ),
                label: const SubtitleText(
                  label: 'Camera',
                  color: Colors.lightBlue,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  onPressedGallery();
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                icon: const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.image_rounded,
                    color: Colors.lightBlue,
                  ),
                ),
                label: const SubtitleText(
                  label: 'Gallery',
                  color: Colors.lightBlue,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  onPressedRemove();
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                icon: const Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.clear,
                    color: Colors.lightBlue,
                  ),
                ),
                label: const SubtitleText(
                  label: 'Remove',
                  color: Colors.lightBlue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
