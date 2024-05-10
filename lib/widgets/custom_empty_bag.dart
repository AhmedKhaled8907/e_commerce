import 'package:e_commerce/screens/root_screen.dart';
import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';

class CustomEmptyBag extends StatelessWidget {
  final String title, subtitle, imagePath;

  const CustomEmptyBag({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24).copyWith(top: 52),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            height: height * 0.35,
            width: double.infinity,
          ),
          const SizedBox(height: 16),
          const TitleText(
            label: 'Whoops',
            fontSize: 40,
            color: Colors.red,
          ),
          const SizedBox(height: 16),
          SubtitleText(
            label: title,
            fontSize: 24,
          ),
          const SizedBox(height: 24),
          SubtitleText(
            label: subtitle,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
          const Expanded(child: SizedBox()),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent.shade700,
              padding: const EdgeInsets.symmetric(
                horizontal: 36,
                vertical: 12,
              ),
            ),
            onPressed: () async {
              await Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const RootScreen(),
                ),
              );
            },
            child: const Text(
              'Shop Now',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
