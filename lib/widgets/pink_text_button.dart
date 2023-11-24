import 'package:flutter/material.dart';
import 'package:new_halo_task/themes/themes.dart';

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
          overlayColor: MaterialStateProperty.all(Colors.pink[400]),
          splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
          mouseCursor: MaterialStateMouseCursor.clickable,
          backgroundColor: MaterialStateProperty.all(
            primaryColor
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
