import 'package:e_commerce/screens/root_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../title_text.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key});

  Future<void> signInWithGoogle(context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);

    if (context.mounted) {
      await Navigator.of(context).pushReplacementNamed(RootScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Ionicons.logo_google, color: Colors.white),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey,
        padding: const EdgeInsets.symmetric(vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      label: const TitleText(
        label: 'Login with Google',
        color: Colors.white,
      ),
      onPressed: () {
        signInWithGoogle(context);
      },
    );
  }
}
