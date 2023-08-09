import 'package:flutter/material.dart';

class ColoredContainer extends StatelessWidget {
  const ColoredContainer({super.key, required this.containerColor, required this.onTap});

  final Color? containerColor;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4),
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          color: containerColor,
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
