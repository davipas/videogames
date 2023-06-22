import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:videogames/presentation/providers/providers.dart';
import 'package:videogames/presentation/screens/home/home_screen.dart';

class Login extends ConsumerWidget {
  const Login({
    super.key,
    required this.size,
    required this.emailController,
    required this.passwordController,
    required this.colors,
  });

  final Size size;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context, ref) {
    return SizedBox(
      height: 60,
      width: size.width * 0.9,
      child: ElevatedButton(
        onPressed: () async {
          try {
            final UserCredential userCredential =
                await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );
            final user = userCredential.user;
            // ignore: use_build_context_synchronously
            context.goNamed(HomeScreen.name,
                  extra: user);
            ref
                  .read(userFirebaseProvider.notifier)
                  .update((state) => user);
          } catch (e) {
            if (e is FirebaseAuthException) {
              if (e.code == 'wrong-password') {
                // Contraseña incorrecta
                ref
                    .read(thereisErrorPasswordLoginProvider.notifier)
                    .update((state) => 'Contraseña Incorrecta');
                ref
                    .read(textEmailLoginProvider.notifier)
                    .update((state) => emailController.text);
              } else if (e.code == 'invalid-email') {
                // Otro tipo de error de autenticación
                ref
                    .read(thereisErrorEmailLoginProvider.notifier)
                    .update((state) => 'Email Invalido');
                ref
                    .read(textEmailLoginProvider.notifier)
                    .update((state) => '');
                ref
                    .read(thereisErrorPasswordLoginProvider.notifier)
                    .update((state) => '');
              } else if (e.code == 'user-not-found') {
                ref
                    .read(thereisErrorEmailLoginProvider.notifier)
                    .update((state) => 'Email no registrado');
                ref
                    .read(textEmailLoginProvider.notifier)
                    .update((state) => '');
                ref
                    .read(thereisErrorPasswordLoginProvider.notifier)
                    .update((state) => '');
              }
            }
          }
        },
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(colors.primary),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)))),
        child: Text(
          'Sign In',
          style: GoogleFonts.secularOne(fontSize: 20, color: colors.onPrimary),
        ),
      ),
    );
  }
}
