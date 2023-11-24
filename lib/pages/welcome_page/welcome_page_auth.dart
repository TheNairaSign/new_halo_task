// ignore_for_file: use_build_context_synchronously

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:googleapis/firestore/v1.dart' as firestore;
// import 'package:googleapis_auth/auth_io.dart' as auth;
// import 'package:http/http.dart' as http;

import 'package:new_halo_task/dashboard/dashboard.dart';
import 'package:new_halo_task/pages/welcome_page/welcome_page.dart';
import 'package:new_halo_task/themes/themes.dart';

class WelcomPageAuth2 extends StatefulWidget {
  const WelcomPageAuth2({Key? key}) : super(key: key);

  @override
  State<WelcomPageAuth2> createState() => _WelcomPageAuth2State();
}

class _WelcomPageAuth2State extends State<WelcomPageAuth2> {
  @override
  void initState() {
    super.initState();
    checkUserStatus();
    // enableFirestoreAPI();
  }

  Future<void> checkUserStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      debugPrint(user.email);
      debugPrint(user.displayName);
      debugPrint(user.uid);
      final userId = user.uid;
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      final hasSeenWelcomePage = userDoc.get('hasSeenWelcomePage') ?? false;

      if (hasSeenWelcomePage) {
        await Future.delayed(const Duration(seconds: 5));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (ctx) => const Dashboard(),
          ),
        );
      }
    } else {
      await Future.delayed(const Duration(seconds: 5));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const WelcomePage(),
        ),
      );
    }
  }

  final spinKit = SpinKitSquareCircle(
    size: 70,
    itemBuilder: (context, index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.white : Colors.teal,
        ),
      );
    },
  );

  final animatedText = AnimatedTextKit(
    animatedTexts: [
      ScaleAnimatedText(
        "Halo",
        scalingFactor: 1,
        textStyle: GoogleFonts.pacifico(
          fontSize: 50,
          fontWeight: FontWeight.bold,
          letterSpacing: 3,
          color: primaryColor,
        ),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: animatedText,
      ),
    );
  }


    }
  
