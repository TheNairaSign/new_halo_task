import 'package:flutter/material.dart';

class PinkTextButton extends StatelessWidget {
  const PinkTextButton({
    super.key,
    required this.onPressed,
    required this.buttonContent,
  });

  final String buttonContent;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 50,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
          mouseCursor: MaterialStateMouseCursor.clickable,
          backgroundColor: MaterialStateProperty.all(
            Colors.pink,
          ),
        ),
        child: Text(
          buttonContent,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
