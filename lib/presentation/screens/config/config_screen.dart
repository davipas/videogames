import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:videogames/presentation/providers/providers.dart';
import 'package:videogames/presentation/widgets/shared/custom_text_font.dart';

class ConfigScreen extends ConsumerWidget {
  const ConfigScreen({super.key});
  static const name = 'config_screen';
  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;
    final isDarkMode = ref.watch(themeNotifierProvider).isDarkMode;
    return Scaffold(
      appBar: AppBar(
        title: CustomTextFont(
            text: 'Configuración',
            fontSize: 25,
            color: colors.onBackground,
            fontWeight: FontWeight.bold),
        actions: [
          IconButton(
              onPressed: () {
                ref.read(themeNotifierProvider.notifier).toggleDarkMode();
                // ref.read(isDarkModeProvider.notifier).update((state) => !state);
              },
              icon: isDarkMode
                  ? const Icon(Icons.light_mode)
                  : const Icon(Icons.dark_mode))
        ],
      ),
      body: const _ConfigScreenView(),
    );
  }
}

class _ConfigScreenView extends ConsumerWidget {
  const _ConfigScreenView();

  @override
  Widget build(BuildContext context, ref) {
    final isDarkMode = ref.watch(themeNotifierProvider).isDarkMode;
    final colorTheme = Theme.of(context).colorScheme;
    final List<Color> colors = ref.watch(colorListProvider);
    // final int selectedColor = ref.watch(selectedColorProvide);
    final int selectedColor = ref.watch(themeNotifierProvider).selectedColor;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            _CustomButtonChoseTheme(
                colorTheme: colorTheme, isDarkMode: isDarkMode),
            const SizedBox(
              height: 20,
            ),
            _CustomExpansion(
                colorTheme: colorTheme,
                colors: colors,
                selectedColor: selectedColor),
            const SizedBox(
              height: 20,
            ),
            const _CustomDialog(),
            const SizedBox(
              height: 20,
            ),
            const _AboutMe()
          ],
        ),
      ),
    );
  }
}

class _AboutMe extends StatelessWidget {
  const _AboutMe();

  @override
  Widget build(BuildContext context) {
    final Uri urlLinkedin =
        Uri.parse('https://www.linkedin.com/in/david-conde-ajno-436821198/');
    final Uri urlFacebook =
        Uri.parse('https://www.facebook.com/davipass');
    final Uri urlWhatsapp =
        Uri.parse('https://wa.link/3d9mki');
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(onPressed: () {
                launchUrl(urlLinkedin);
            
          }, icon: Icon(MdiIcons.linkedin,size: 60,)),
          IconButton(onPressed: () {
                launchUrl(urlWhatsapp);
            
          }, icon: Icon(MdiIcons.whatsapp,size: 60,)),
          IconButton(onPressed: () {
                launchUrl(urlFacebook);
            
          }, icon: Icon(MdiIcons.facebook,size: 60,))
        ],
      ),
    );
  }
}

class _CustomDialog extends StatelessWidget {
  const _CustomDialog();

  void openDialog(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Game Trends ',
          textAlign: TextAlign.center,
        ),
        actionsAlignment: MainAxisAlignment.spaceBetween,
        content: const Text(
            'Game Trends es una aplicación informativa que te mantiene al tanto de las últimas noticias sobre videojuegos. Descubre las novedades de la industria y encuentra recomendaciones de juegos emocionantes. Mantente informado y disfruta de la experiencia de juego con Game Trends '),
        actions: [
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: colors.primary),
            height: 40,
            width: 100,
            child: Center(
                child: Text(
              'V 1.0.0',
              style: TextStyle(color: colors.onPrimary),
            )),
          ),
          FilledButton(onPressed: () => context.pop(), child: const Text('OK')),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorTheme = Theme.of(context).colorScheme;
    return Container(
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
          color: colorTheme.primaryContainer,
          borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => openDialog(context),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFont(
                  text: 'Ver mas sobre la aplicación',
                  fontSize: 20,
                  color: colorTheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CustomExpansion extends ConsumerWidget {
  const _CustomExpansion({
    required this.colorTheme,
    required this.colors,
    required this.selectedColor,
  });

  final ColorScheme colorTheme;
  final List<Color> colors;
  final int selectedColor;

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: colorTheme.primaryContainer,
          borderRadius: BorderRadius.circular(20)),
      child: ExpansionTile(
        collapsedShape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: CustomTextFont(
            text: 'Cambiar el tema',
            fontSize: 20,
            color: colorTheme.onPrimaryContainer,
            fontWeight: FontWeight.bold,
            textAlign: TextAlign.center),
        children: [
          ListView.builder(
            shrinkWrap: true,
            itemCount: colors.length,
            itemBuilder: (context, index) {
              final color = colors[index];
              return RadioListTile(
                title: CustomTextFont(
                  text: 'Elije tu tema',
                  fontSize: 20,
                  color: colorTheme.onPrimaryContainer,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.start,
                ),
                subtitle: CustomTextFont(
                  text: 'Color',
                  fontSize: 15,
                  color: color,
                  fontWeight: FontWeight.normal,
                  textAlign: TextAlign.start,
                ),
                activeColor: color,
                value: index,
                groupValue: selectedColor,
                onChanged: (value) {
                  ref
                      .watch(themeNotifierProvider.notifier)
                      .changeColorIndex(index);
                  // ref.read(selectedColorProvider.notifier).state = index;
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _CustomButtonChoseTheme extends ConsumerWidget {
  const _CustomButtonChoseTheme({
    required this.colorTheme,
    required this.isDarkMode,
  });

  final ColorScheme colorTheme;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      height: 55,
      width: double.infinity,
      decoration: BoxDecoration(
          color: colorTheme.primaryContainer,
          borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => ref.read(themeNotifierProvider.notifier).toggleDarkMode(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomTextFont(
                  text: isDarkMode ? 'Modo claro' : 'Modo oscuro',
                  fontSize: 20,
                  color: colorTheme.onPrimaryContainer,
                  fontWeight: FontWeight.bold),
              const SizedBox(
                width: 10,
              ),
              Icon(
                isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: !isDarkMode
                    ? const Color.fromARGB(255, 8, 67, 116)
                    : Colors.yellow,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
