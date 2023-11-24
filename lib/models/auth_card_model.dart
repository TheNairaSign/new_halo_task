// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:new_halo_task/provider/google_sign_in_provider.dart';
import 'package:provider/provider.dart';

class AuthCardModel {
  final void Function() onTap;
  final bool svg;
  final String text;
  final String widgetUrl;

  AuthCardModel({
    required this.onTap,
    required this.svg,
    required this.text,
    required this.widgetUrl,
  });

  static List<AuthCardModel> authCard(BuildContext context) {
    List<AuthCardModel> authModels = [];

    authModels.add(
      AuthCardModel(
      onTap: () {
        print("Facebook");
      },
      svg: false,
      text: "Continue with Facebook",
      widgetUrl: "assets/socials/facebook-logo.png",
    ));
    authModels.add(
      AuthCardModel(
      onTap: () {
        debugPrint("Google Tapped");
        final provider = context.read<GoogleSignInProvider>();
        provider.googleLogin();
        // AuthServices().handleSignIn();
      },
      svg: true,
      text: "Continue with Google",
      widgetUrl: "assets/socials/google-logo.svg",
    ));
    authModels.add(
      AuthCardModel(
      onTap: () {
        print("Apple");

      },
      svg: true,
      text: "Continue with Apple",
      widgetUrl: "assets/socials/apple-logo.svg",
    ));
    return authModels;
  }
}
