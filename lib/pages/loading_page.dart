import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          // mainAxisAlignment: MainAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Halo task", style: GoogleFonts.sacramento(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 70
      
            ),),
            // const Spacer(),
            // Center(
            //   child: Image.asset("assets/halo-task.png"),
            // ),
            // const Spacer(),
            const Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: SpinKitCircle(
                color: Colors.white,
                // itemBuilder: (context, index) => const LoadingPage(),
                duration: Duration(seconds: 3),
                size: 70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
