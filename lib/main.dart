import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_halo_task/pages/welcome_page.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  runApp(const NewHaloTask());
}

class NewHaloTask extends StatelessWidget {
  const NewHaloTask({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WelcomePage(),
      theme: ThemeData().copyWith(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
      ),
      darkTheme: ThemeData().copyWith(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey[900],
      ),
    );
  }
}
