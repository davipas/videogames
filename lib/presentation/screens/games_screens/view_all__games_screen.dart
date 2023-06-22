import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:videogames/domain/entities/game.dart';
import 'package:videogames/presentation/providers/providers.dart';
import 'package:videogames/presentation/widgets/shared/custom_text_font.dart';

class ViewAllGamesScreen extends ConsumerWidget {
  final String type;
  static const String name = 'view_all_games_screen';
  const ViewAllGamesScreen({super.key, required this.type});

  @override
  Widget build(BuildContext context, ref) {
    //Identificamos asi la categoria porque la api no tiene un endpoint para las categorias
    var games = ref.watch(gamesAlphabeticallyProvider);
    if (type == 'populares') {
      games = ref.watch(gamesPopularProvider);
    }
    if (type == 'relevantes') {
      games = ref.watch(gamesProvider);
    }
    if (type == 'ultimos') {
      games = ref.watch(gamesLatestProvider);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Juegos $type '),
      ),
      body: ListView.builder(
        itemCount: games.length,
        itemBuilder: (context, index) {
          return _CustomCards(game: games[index]);
        },
      ),
    );
  }
}

class _CustomCards extends StatelessWidget {
  final Game game;
  const _CustomCards({required this.game});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      // color: colors.primary,
      child: InkWell(
        onTap: () => context.push('/game_details_screen/${game.id}'),
        child: SizedBox(
          height: 206,
          child: Row(
            children: [
              _GameImage(game: game),
              _GameData(game: game, colors: colors)
            ],
          ),
        ),
      ),
    );
  }
}

class _GameData extends StatelessWidget {
  const _GameData({
    required this.game,
    required this.colors,
  });

  final Game game;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CustomTextFont(
            text: game.title,
            fontSize: 16,
            color: colors.onBackground,
            fontWeight: FontWeight.bold,
            maxLines: 2,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextFont(
            text: game.shortDescription,
            fontSize: 12,
            color: colors.primary,
            fontWeight: FontWeight.w100,
            maxLines: 4,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomTextFont(text: 'Plataforma: ', fontSize: 20, color: colors.onBackground, fontWeight: FontWeight.bold),
            Icon(
              game.platform == 'PC (Windows)'
                  ? Icons.laptop_windows
                  : Icons.web,
              color: colors.onBackground,
              size: 30,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: colors.primary
            ),
            child: CustomTextFont(text:game.genre, fontSize: 20, color: colors.onPrimary, fontWeight: FontWeight.w900),
          ),
        )
      ],
    ));
  }
}

class _GameImage extends StatelessWidget {
  const _GameImage({
    required this.game,
  });

  final Game game;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          topLeft: Radius.circular(30)),
      child: Image.network(
        game.thumbnail,
        width: 230,
        height: 206,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress != null) {
            return const Padding(
              padding: EdgeInsets.all(8),
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            );
          }
          return child;
        },
      ),
    );
  }
}
