// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSnackbarContent extends StatelessWidget {
  const CustomSnackbarContent({
    Key? key,
    required this.content,
    required this.color,
    required this.onConsent,
  }) : super(key: key);
  final String content;
  final Color? color;
  final void Function() onConsent;

  @override
  Widget build(BuildContext context) {
    const svgColor = Color.fromARGB(255, 103, 10, 4);
    final transparent = MaterialStateProperty.all(Colors.transparent);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: 110,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Colors.red,
                Color.fromARGB(255, 211, 48, 36),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: SvgPicture.asset(
                  "assets/svg/snackBar/close.svg",
                  height: 20,
                  width: 20,
                  color: svgColor,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Oh snap!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      content,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            onConsent();
                          },
                          child: const Text(
                            "Yes",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: svgColor,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
            ),
            child: SvgPicture.asset(
              "assets/svg/snackBar/bubbles.svg",
              height: 48,
              width: 40,
              color: svgColor,
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
            ),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationZ(
                  3.14159265359), // Rotate 180 degrees (pi radians)
              child: SvgPicture.asset(
                "assets/svg/snackBar/bubbles.svg",
                height: 48,
                width: 40,
                color: svgColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
