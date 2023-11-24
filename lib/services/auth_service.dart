import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  Future handleSignIn() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final GoogleSignInAuthentication googleSignInAuthentication = await googleUser!.authentication;

      final androidCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);

      return await FirebaseAuth.instance.signInWithCredential(androidCredential);
    } catch (error) {
      // Handle error
      print('Error during sign-in: $error');
    }  
  }
}
