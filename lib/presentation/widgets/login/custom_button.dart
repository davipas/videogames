import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final String nameScreen;
  final double width;

  const CustomButton(
      {super.key,
      required this.text,
      required this.color,
      required this.textColor,
      required this.nameScreen, required this.width});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: width,
      child: ElevatedButton(
        onPressed: () {
          context.pushNamed(nameScreen);
        },
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(color),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)))),
        child: Text(
          text,
          style: GoogleFonts.secularOne(fontSize: 20, color: textColor),
        ),
      ),
    );
  }
}
