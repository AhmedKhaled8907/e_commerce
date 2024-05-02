import 'package:e_commerce/consts/assets.dart';
import 'package:e_commerce/widgets/subtitle_text.dart';
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
                    onPressed;
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
}
