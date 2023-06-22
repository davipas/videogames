import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WidgetDividerWithText extends StatelessWidget {
  const WidgetDividerWithText({
    super.key,
    required this.colors, required this.text,
  });
  final ColorScheme colors;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: colors.onBackground,
            thickness: 3,
            indent: 30,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            text,
            style: GoogleFonts.secularOne(
              fontSize: 15,
              fontWeight: FontWeight.w100,
              color: colors.onBackground,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: colors.onBackground,
            thickness: 3,
            endIndent: 30,
          ),
        ),
      ],
    );
  }
}
