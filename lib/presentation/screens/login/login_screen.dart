import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:videogames/presentation/providers/login/input_login_provider.dart';
import 'package:videogames/presentation/screens/screens.dart';
import 'package:videogames/presentation/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  static const String name = 'login_screen';

  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: _LoginScreenView(
        size: size,
        colors: colors,
      ),
    );
  }
}

class _LoginScreenView extends ConsumerWidget {
  const _LoginScreenView({
    required this.size,
    required this.colors,
  });

  final Size size;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context, ref) {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final thereisErrorEmail = ref.watch(thereisErrorEmailLoginProvider);
    final thereisErrorPassword = ref.watch(thereisErrorPasswordLoginProvider);
    final textEmailLogin = ref.watch(textEmailLoginProvider);
    if (textEmailLogin != '') {
      emailController.text = textEmailLogin;
    }
    return SingleChildScrollView(
      child: Container(
          width: double.infinity,
          // height: size.height,
          decoration: BoxDecoration(
            color: colors.background,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 65, horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Bienvenido de nuevo',
                  style: GoogleFonts.secularOne(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: colors.onBackground),
                ),
                Text(
                  'Inicia sesión con tu correo y contraseña,o tambien puede iniciar con Google o Facebook',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.secularOne(
                      fontSize: 16,
                      fontWeight: FontWeight.w100,
                      color: colors.onBackground),
                ),
                const SizedBox(
                  height: 30,
                ),
                Form(
                    child: Column(children: [
                  TextFormField(
                      controller: emailController,
                      style: GoogleFonts.secularOne(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.email,
                            color: Colors.black,
                          ),
                          hintText: 'Email',
                          errorText: thereisErrorEmail != ''
                              ? thereisErrorEmail
                              : null,
                          hintStyle: GoogleFonts.secularOne(
                              fontSize: 15,
                              fontWeight: FontWeight.w100,
                              color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40)),
                          filled: true,
                          fillColor: Colors.grey.shade300)),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      controller: passwordController,
                      style: GoogleFonts.secularOne(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                      decoration: InputDecoration(
                          suffixIcon: const Icon(
                            Icons.remove_red_eye,
                            color: Colors.black,
                          ),
                          prefixIcon: const Icon(
                            Icons.password_outlined,
                            color: Colors.black,
                          ),
                          hintText: 'Password',
                          errorText: thereisErrorPassword != ''
                              ? thereisErrorPassword
                              : null,
                          hintStyle: GoogleFonts.secularOne(
                              fontSize: 15,
                              fontWeight: FontWeight.w100,
                              color: Colors.black),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40)),
                          filled: true,
                          fillColor: Colors.grey.shade300)),
                  _TextButton(colors: colors),
                  const SizedBox(
                    height: 10,
                  ),
                  Login(
                  size: size,
                  emailController: emailController,
                  passwordController: passwordController,
                  colors: colors),
                ])),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  text: 'Cancel',
                  color: colors.secondary,
                  textColor: colors.onSecondary,
                  nameScreen: WelcomeScreen.name,
                  width: size.width * 0.9,
                ),
                const SizedBox(
                  height: 20,
                ),
                WidgetDividerWithText(
                  colors: colors,
                  text: 'Or Sign up With',
                ),
                const SizedBox(
                  height: 20,
                ),
                ButtonGoogle(
                    size: size,
                    firebaseAuth: firebaseAuth,
                    googleSignIn: googleSignIn,
                    colors: colors),
                const SizedBox(
                  height: 10,
                ),
                CustomButtonWithImage(
                  size: size,
                  colors: colors,
                  text: 'Facebook',
                  urlIcon: 'assets/icons/facebook.png',
                  textColor: Colors.blue,
                  borderColor: Colors.blue,
                  overlayColor: Colors.blue.shade100,
                )
              ],
            ),
          )),
    );
  }
}

class _TextButton extends StatelessWidget {
  const _TextButton({
    required this.colors,
  });

  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
            onPressed: () {
              //TODO: Metodo de olvido la contraseña
            },
            child: Text(
              'Forgot Password ?',
              style: GoogleFonts.secularOne(
                  fontSize: 15,
                  fontWeight: FontWeight.w100,
                  color: colors.onBackground),
            )),
      ],
    );
  }
}
