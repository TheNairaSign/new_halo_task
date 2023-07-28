import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:new_halo_task/auth/signup_auth_page.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

import 'package:new_halo_task/themes/themes.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  runApp(const NewHaloTask());
}

class NewHaloTask extends StatelessWidget {
  const NewHaloTask({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SignUpAuth(),
      theme: lightTheme,
      darkTheme: darkTheme,
    );
  }
}
