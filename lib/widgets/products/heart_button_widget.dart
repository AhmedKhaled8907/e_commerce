import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class HeartButtonWidget extends StatefulWidget {
  final Color color;
  final Color iconColor;
  final double size;

  const HeartButtonWidget({
    super.key,
    this.color = Colors.transparent,
    this.size = 24,
    this.iconColor = Colors.white,
  });

  @override
  State<HeartButtonWidget> createState() => _HeartButtonWidgetState();
}

class _HeartButtonWidgetState extends State<HeartButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.color,
      ),
      child: IconButton(
        onPressed: () {},
        icon: Icon(
          IconlyLight.heart,
          color: widget.iconColor,
          size: widget.size,
        ),
      ),
    );
  }
}
