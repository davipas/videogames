import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:videogames/presentation/screens/config/config_screen.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Icon(
                  MdiIcons.gamepadSquare,
                  color: colors.primary,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Game Trends',
                  style: GoogleFonts.pressStart2p(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: colors.primary,),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      context.pushNamed(ConfigScreen.name);
                    },
                    icon: Icon(
                      Icons.settings,
                      color: colors.primary,
                    ))
              ],
            ),
          ),
        ));
  }
}
