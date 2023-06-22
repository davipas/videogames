import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:videogames/domain/entities/game_by_id.dart';
import 'package:videogames/presentation/providers/game/game_info_provider.dart';
import 'package:videogames/presentation/widgets/widgets.dart';

class GameDetailsScreen extends ConsumerStatefulWidget {
  static const name = 'game_details_screen';
  final String id;
  const GameDetailsScreen({required this.id, super.key});

  @override
  GameDetailsState createState() => GameDetailsState();
}

class GameDetailsState extends ConsumerState<GameDetailsScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(gameInfoProvider.notifier).loadGame(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final GameById? game = ref.watch(gameInfoProvider)[widget.id];
    if (game == null) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }
    return Scaffold(
        appBar: AppBar(
            title: CustomTextFont(
                text: 'Sobre el Juego',
                fontSize: 25,
                color: colors.onBackground,
                fontWeight: FontWeight.bold)),
        body: _GameDetailsView(game: game));
  }
}

class _GameDetailsView extends StatelessWidget {
  final GameById game;
  const _GameDetailsView({required this.game});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
            child: Image.network(
              game.thumbnail,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Divider(
                height: 20,
                thickness: 2,
                color: colors.onBackground,
              ),
          Column(
            children: [
              CustomTextFont(
                  text: game.title,
                  fontSize: 35,
                  color: colors.onBackground,
                  fontWeight: FontWeight.bold),
              CustomTextFont(
                text: game.shortDescription,
                fontSize: 25,
                color: colors.onBackground,
                fontWeight: FontWeight.w100,
                maxLines: 5,
              ),
              Divider(
                height: 20,
                thickness: 2,
                color: colors.onBackground,
              ),
              _GameData(colors: colors, game: game),
              Divider(
                height: 20,
                thickness: 2,
                color: colors.onBackground,
              ),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: game.screenshots.length,
                  itemBuilder: (context, index) {
                    final screenshot = game.screenshots[index];
                    return _ScreenshotGame(
                      screenshot: screenshot,
                    );
                  },
                ),
              ),
              Divider(
                height: 20,
                thickness: 2,
                color: colors.onBackground,
              ),
              _ContainerRequirements(colors: colors, game: game),
              const SizedBox(height: 10,)
            ],
          ),
        ],
      ),
    );
  }
}

class _GameData extends StatelessWidget {
  const _GameData({
    required this.colors,
    required this.game,
  });

  final ColorScheme colors;
  final GameById game;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: colors.primary),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomTextFont(
                text: 'Estado:   ${game.status}',
                fontSize: 15,
                color: colors.onPrimary,
                fontWeight: FontWeight.normal),
            Icon(
              Icons.live_tv,
              color:
                  game.status == "Live" ? Colors.green : Colors.red,
            ),
            CustomTextFont(
                text: 'Genero: ${game.genre}',
                fontSize: 15,
                color: colors.onSecondary,
                fontWeight: FontWeight.normal),
            CustomTextFont(
                text: 'Plataforma: ${game.platform}',
                fontSize: 15,
                color: colors.onSecondary,
                fontWeight: FontWeight.normal)
          ],
        ),
      ),
    );
  }
}

class _ContainerRequirements extends StatelessWidget {
  const _ContainerRequirements({
    required this.colors,
    required this.game,
  });

  final ColorScheme colors;
  final GameById game;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30)),
          color: colors.primary),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFont(
              text: 'Requerimientos para jugar',
              fontSize: 30,
              color: colors.onPrimary,
              fontWeight: FontWeight.bold,
            ),
            _CustomRequirements(
              text:
                  'Sistema Operativo : ${game.minimumSystemRequirements.os}',
            ),
            _CustomRequirements(
              text:
                  'Procesador : ${game.minimumSystemRequirements.processor}',
            ),
            _CustomRequirements(
              text: 'Ram : ${game.minimumSystemRequirements.memory}',
            ),
            _CustomRequirements(
              text:
                  'Gráficos : ${game.minimumSystemRequirements.graphics}',
            ),
            _CustomRequirements(
              text:
                  'Memoria : ${game.minimumSystemRequirements.storage}',
            ),
          ],
        ),
      ),
    );
  }
}

class _CustomRequirements extends StatelessWidget {
  const _CustomRequirements({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return CustomTextFont(
      text: text,
      fontSize: 20,
      color: colors.onPrimary,
      fontWeight: FontWeight.bold,
      textAlign: TextAlign.justify,
    );
  }
}

class _ScreenshotGame extends StatelessWidget {
  const _ScreenshotGame({required this.screenshot});
  final Screenshot screenshot;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: colors.onBackground,
        borderRadius: BorderRadius.circular(20)
      ),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 400,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            screenshot.image,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) {
                return const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  ),
                );
              }
              return child;
            },
          )),
    );
  }
}
