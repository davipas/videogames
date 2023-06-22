import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFont extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  const CustomTextFont(
      {super.key,
      required this.text,
      required this.fontSize,
      required this.color,
      required this.fontWeight,
      this.textAlign = TextAlign.center, this.maxLines = 2});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      textAlign: textAlign,
      style: GoogleFonts.lilitaOne(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
