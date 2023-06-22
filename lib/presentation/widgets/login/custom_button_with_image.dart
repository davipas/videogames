import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButtonWithImage extends StatelessWidget {
  const CustomButtonWithImage({super.key, 
    required this.size,
    required this.colors,
    required this.text,
    required this.urlIcon,
    required this.textColor,
    required this.borderColor, required this.overlayColor,
  });

  final Size size;
  final ColorScheme colors;
  final String text;
  final String urlIcon;
  final Color textColor;
  final Color borderColor;
  final Color overlayColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: size.width * 0.9,
      child: ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(
              elevation: const MaterialStatePropertyAll(0),
              backgroundColor: MaterialStatePropertyAll(colors.background),
              foregroundColor: MaterialStatePropertyAll(borderColor),
              overlayColor: MaterialStatePropertyAll(overlayColor),
              // shadowColor: MaterialStatePropertyAll(borderColor),
              side: MaterialStatePropertyAll(
                  BorderSide(color: borderColor, width: 3)),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)))),
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Image.asset(
                    urlIcon,
                    width: 30,
                    height: 30,
                  )),
              Align(
                  alignment: Alignment.center,
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.secularOne(
                      fontSize: 20,
                      fontWeight: FontWeight.w100,
                      color: textColor,
                    ),
                  ))
            ],
          )),
    );
  }
}
