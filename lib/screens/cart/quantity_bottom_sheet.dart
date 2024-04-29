import 'dart:developer';

import 'package:e_commerce/widgets/subtitle_text.dart';
import 'package:flutter/material.dart';

class QuantityBottomSheet extends StatelessWidget {
  const QuantityBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            width: 50,
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade300,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: 15,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  log(index.toString());
                },
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Center(
                    child: SubtitleText(
                      label: (index + 1).toString(),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
