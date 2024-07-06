// import 'package:herafy/core/widgets/toast.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:herafy/core/widgets/toast.dart';

import '../../../core/widgets/buttons.dart';
import 'package:flutter/material.dart';

class ExternalSignOptions extends StatelessWidget {
  const ExternalSignOptions({super.key});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        buildOptionButton(
          src: 'google',
          onTap: () async {
            try {
              final FirebaseAuth auth = FirebaseAuth.instance;
              final GoogleSignIn googleSignIn = GoogleSignIn();
              final GoogleSignInAccount? googleUser =
                  await googleSignIn.signIn();
              if (googleUser != null) {
                final GoogleSignInAuthentication googleAuth =
                    await googleUser.authentication;
                final AuthCredential credential = GoogleAuthProvider.credential(
                  accessToken: googleAuth.accessToken,
                  idToken: googleAuth.idToken,
                );
                await auth.signInWithCredential(credential);
                FailureToast.showToast(
                    msg: auth.currentUser?.uid ?? "Not Found");
              }
             
            } catch (e) {
              FailureToast.showToast(msg: e.toString());
            }
          },
        ),
        const Text("data")
        // buildOptionButton(
        //   src: 'apple',
        //   onTap: () => dialog(msg: "Apple ID"),
        // ),
        // buildOptionButton(
        //   icon: Icons.phone_android,
        //   iconSize: 28,
        //   onTap: () => dialog(msg: "Phone"),
        // ),
        // buildOptionButton(
        //   src: 'facebook',
        //   onTap: () => dialog(msg: "facebook"),
        // ),
      ],
    );
  }
}
