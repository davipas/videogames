import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:videogames/presentation/providers/login/input_login_provider.dart';
import 'package:videogames/presentation/widgets/widgets.dart';
import 'package:videogames/presentation/screens/screens.dart';

class RegisterScreen extends StatelessWidget {
  static const String name = 'register_screen';
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      body: _RegisterScreenView(
        size: size,
        colors: colors,
      ),
    );
  }
}

class _RegisterScreenView extends ConsumerWidget {
  const _RegisterScreenView({
    required this.size,
    required this.colors,
  });
  final Size size;
  final ColorScheme colors;
  @override
  Widget build(BuildContext context, ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final thereisErrorEmail = ref.watch(thereisErrorEmailRegisterProvider);
    final thereisErrorPassword = ref.watch(thereisErrorPasswordRegisterProvider);
    final textEmailLogin = ref.watch(textEmailRegisterProvider);
    if (textEmailLogin != '') {
      emailController.text = textEmailLogin;
    }
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        // height: size.height * 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 65, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Bienvenido Registrate ',
                style: GoogleFonts.secularOne(
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    color: colors.onBackground),
              ),
              Text(
                'Puedes registrarte con tu email y contraseña o iniciar sesion con tu cuenta de Google',
                textAlign: TextAlign.center,
                style: GoogleFonts.secularOne(
                    fontSize: 16,
                    fontWeight: FontWeight.w100,
                    color: colors.onBackground),
              ),
              Form(
                  child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      controller: emailController,
                      style: GoogleFonts.secularOne(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                      decoration: InputDecoration(
                          prefixIcon: const Icon(
                            Icons.person_2_rounded,
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
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )),
              Register(size: size, emailController: emailController, passwordController: passwordController, colors: colors),
              const SizedBox(
                height: 15,
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
                text: 'Or Register up With',
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButtonWithImage(
                size: size,
                colors: colors,
                text: 'Google',
                urlIcon: 'assets/icons/google.png',
                textColor: Colors.red,
                borderColor: Colors.red,
                overlayColor: Colors.red.shade100,
              ),
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
        ),
      ),
    );
  }
}


