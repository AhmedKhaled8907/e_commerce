import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class RequestLinkButton extends StatelessWidget {
  const RequestLinkButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(12),
          backgroundColor: Colors.blue.shade700,
          // backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        icon: const Icon(IconlyBold.send, color: Colors.white),
        label: const Text(
          "Request link",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        onPressed: () async {},
      ),
    );
  }
}


