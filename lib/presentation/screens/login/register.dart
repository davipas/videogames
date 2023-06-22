import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:videogames/presentation/providers/providers.dart';
import 'package:videogames/presentation/screens/home/home_screen.dart';

class Register extends ConsumerWidget {
  const Register({
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
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );
            final user = userCredential.user;
            // ignore: use_build_context_synchronously
            context.goNamed(HomeScreen.name, extra: user);
            ref.read(userFirebaseProvider.notifier).update((state) => user);
          } catch (e) {
            if (e is FirebaseAuthException) {
              if (e.code == 'weak-password') {
                // Contraseña incorrecta
                ref
                    .read(thereisErrorPasswordRegisterProvider.notifier)
                    .update((state) => 'Contraseña no cumple con los requisitos');
                ref
                    .read(textEmailRegisterProvider.notifier)
                    .update((state) => emailController.text);
              } else if (e.code == 'invalid-email') {
                // Otro tipo de error de autenticación
                ref
                    .read(thereisErrorEmailRegisterProvider.notifier)
                    .update((state) => 'Email Invalido');
                ref.read(textEmailRegisterProvider.notifier).update((state) => '');
                ref
                    .read(thereisErrorPasswordRegisterProvider.notifier)
                    .update((state) => '');
              } else if (e.code == 'email-already-in-use') {
                ref
                    .read(thereisErrorEmailRegisterProvider.notifier)
                    .update((state) => 'El email ya esta en uso');
                ref.read(textEmailRegisterProvider.notifier).update((state) => '');
                ref
                    .read(thereisErrorPasswordRegisterProvider.notifier)
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
          'Sign Up',
          style: GoogleFonts.secularOne(fontSize: 20, color: colors.onPrimary),
        ),
      ),
    );
  }
}
