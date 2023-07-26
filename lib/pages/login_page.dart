import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:new_halo_task/pages/signup_page.dart';
import 'package:new_halo_task/widgets/text_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: bodyPadding(context),
    );
  }

  Padding bodyPadding(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            child: Text(
              "Let's let you in",
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
          socialsCard(
            context,
            () {
              print("Facebook");
            },
            false,
            "Continue with Facebook",
            "assets/socials/facebook-logo.png",
          ),
          socialsCard(
            context,
            () {
              print("Google");
            },
            true,
            "Continue with Google",
            "assets/socials/google-logo.svg",
          ),
          socialsCard(
            context,
            () {
              print("Google");
            },
            true,
            "Continue with Apple",
            "assets/socials/apple-logo.svg",
          ),
          Padding(
            padding:
                const EdgeInsets.only(bottom: 60, top: 50, right: 20, left: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Divider(
                  indent: 150,
                  endIndent: 10,
                  color: Colors.white,
                  thickness: 2,
                ),
                Text(
                  "Or",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                ),
                const Divider(
                  indent: 150,
                  endIndent: 10,
                  thickness: 2,
                  color: Colors.amber,
                ),
              ],
            ),
          ),
          // const Spacer(),
          PinkTextButton(
            onPressed: () {
              // Navigator.of(context).push(MaterialPageRoute(builder: (context) => const UserLoginPage()));
            },
            buttonContent: "Sign In with password",
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account?",
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
              ),
              TextButton(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                    Colors.transparent,
                  ),
                ),
                onPressed: () {
                  print("Sign up");
                  Navigator.of(context).push(MaterialPageRoute(builder: ((context) => const SignUpPage())));
                },
                child: const Text(
                  "Sign up",
                  style: TextStyle(color: Colors.pink),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  SizedBox socialsCard(
    BuildContext context,
    void Function() onTap,
    bool svg,
    String text,
    String widgetUrl,
  ) {
    return SizedBox(
      height: 100,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(20),
        elevation: 1,
        child: InkWell(
          customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onTap: onTap,
          radius: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                svg == false
                    ? Image.asset(
                        widgetUrl,
                        height: 70,
                        width: 75,
                      )
                    : SvgPicture.asset(
                        widgetUrl,
                        height: 60,
                        alignment: Alignment.bottomLeft,
                      ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  text,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
