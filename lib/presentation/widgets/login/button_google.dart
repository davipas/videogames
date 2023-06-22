import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:videogames/presentation/providers/login/user_google_provider.dart';
import 'package:videogames/presentation/screens/home/home_screen.dart';
import 'package:videogames/presentation/screens/login/user_context_google.dart';
class ButtonGoogle extends ConsumerWidget {
  const ButtonGoogle({
    super.key,
    required this.size,
    required this.firebaseAuth,
    required this.googleSignIn,
    required this.colors,
  });

  final Size size;
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context, ref) {
        loginWithGoogle() async {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential authCredential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      try {
        final UserCredential userCredential =
            await firebaseAuth.signInWithCredential(authCredential);
        return userCredential;
      } catch (e) {
        return null;
      }
    }
    return SizedBox(
      height: 60,
      width: size.width * 0.9,
      child: ElevatedButton(
          onPressed: () async {
            UserCredential? userCredentialFinal =
                await loginWithGoogle();
            if (userCredentialFinal != null) {
              UserContextGoogle userContextGoogle =
                  UserContextGoogle(
                      user: userCredentialFinal.user,
                      auth: firebaseAuth,
                      googleSignIn: googleSignIn);
              ref
                  .read(userGoogleProvider.notifier)
                  .update((state) => userCredentialFinal.user);
              // ignore: use_build_context_synchronously
              context.goNamed(HomeScreen.name,
                  extra: userContextGoogle);
            }
          },
          style: ButtonStyle(
              elevation: const MaterialStatePropertyAll(0),
              backgroundColor:
                  MaterialStatePropertyAll(colors.background),
              foregroundColor:
                  const MaterialStatePropertyAll(Colors.red),
              overlayColor:
                  MaterialStatePropertyAll(Colors.red.shade100),
              // shadowColor: MaterialStatePropertyAll(borderColor),
              side: const MaterialStatePropertyAll(
                  BorderSide(color: Colors.red, width: 3)),
              shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)))),
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    'assets/icons/google.png',
                    width: 30,
                    height: 30,
                  )),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Google',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.secularOne(
                      fontSize: 20,
                      fontWeight: FontWeight.w100,
                      color: Colors.red,
                    ),
                  ))
            ],
          )),
    );
  }
}