import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [],
      ),
    );
  }

  SizedBox socialsCard(
    Widget logo,
    String text,
    bool svg,
    String widgetUrl,
  ) {
    return SizedBox(
      height: 100,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(20),
        elevation: 5,
        color: Colors.white,
        child: Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              svg == false
                  ? Image.asset(widgetUrl)
                  : SvgPicture.asset(widgetUrl),
              const SizedBox(
                width: 10,
              ),
              Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
