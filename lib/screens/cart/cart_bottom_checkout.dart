import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:e_commerce/widgets/title_text.dart';
import 'package:flutter/material.dart';

class CartBottomCheckout extends StatelessWidget {
  const CartBottomCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: const Border(
          top: BorderSide(color: Colors.grey, width: 2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleText(label: 'Total (6 products /6 items)'),
                SubtitleText(label: '\$ 300.00'),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent.shade700),
              child: const SubtitleText(
                label: 'Checkout',
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
