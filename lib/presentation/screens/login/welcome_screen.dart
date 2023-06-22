import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:go_router/go_router.dart';
import 'package:videogames/presentation/screens/screens.dart';

class WelcomeScreen extends ConsumerWidget {
  static const String name = 'welcome_screen';
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    return const Scaffold(
      body: _WelcomeView(),
    );
  }
}

class _WelcomeView extends StatelessWidget {
  const _WelcomeView();

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        _AnimationWidget(
          size: size,
          color: colors,
        ),
        _WelcomeWidget(
          size: size,
          color: colors,
        )
      ],
    );
  }
}

class _AnimationWidget extends StatelessWidget {
  const _AnimationWidget({
    required this.size,
    required this.color,
  });

  final Size size;
  final ColorScheme color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: size.height * 0.6,
      decoration: BoxDecoration(
          color: color.primary,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.elliptical(120, 50),
              bottomRight: Radius.elliptical(120, 50))),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInDown(child: Lottie.asset('assets/animations/play.json')),
          const SizedBox(
            height: 10,
          ),
          FadeInDown(
            child: Text('Bienvenido',
                style: GoogleFonts.secularOne(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 10,
                    color: color.onPrimary)),
          )
        ],
      ),
    );
  }
}

class _WelcomeWidget extends StatelessWidget {
  const _WelcomeWidget({
    required this.size,
    required this.color,
  });

  final Size size;
  final ColorScheme color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      width: double.infinity,
      height: size.height * 0.4,
      decoration: BoxDecoration(
        color: color.background,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Hola!',
            style: GoogleFonts.secularOne(
                fontSize: 40,
                fontWeight: FontWeight.w200,
                color: color.onBackground),
          ),
          Text(
            'Bienvenido a la mejor aplicacion de informacion sobre videojuegos Disfrutala!!',
            style: GoogleFonts.secularOne(
                fontSize: 18,
                fontWeight: FontWeight.w100,
                color: color.onBackground),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_buttonSignIn(context), _buttonRegister(context)],
          )
        ],
      ),
    );
  }

  SizedBox _buttonRegister(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 170,
      child: ElevatedButton(
          onPressed: () {
            context.pushNamed(RegisterScreen.name);
          },
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(color.background),
              elevation: const MaterialStatePropertyAll(10),
              shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20))))),
          child: Text(
            'Sign Up',
            style: GoogleFonts.secularOne(
                fontSize: 20,
                fontWeight: FontWeight.w100,
                color: color.onBackground),
          )),
    );
  }

  SizedBox _buttonSignIn(BuildContext context) {
    return SizedBox(
      height: 70,
      width: 170,
      child: ElevatedButton(
          onPressed: () {
            context.pushNamed(LoginScreen.name);
          },
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(color.primary),
              elevation: const MaterialStatePropertyAll(10),
              shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20))))),
          child: Text(
            'Sign In',
            style: GoogleFonts.secularOne(
                fontSize: 20,
                fontWeight: FontWeight.w100,
                color: color.onPrimary),
          )),
    );
  }
}
