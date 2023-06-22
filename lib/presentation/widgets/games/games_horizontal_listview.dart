import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:videogames/domain/entities/game.dart';
import 'package:videogames/presentation/widgets/widgets.dart';

class GameHorizontalListview extends StatelessWidget {
  final List<Game> games;
  final String title;
  final String subtitle;
  final String type;
  const GameHorizontalListview(
      {super.key,
      required this.games,
      required this.title,
      required this.subtitle,
      required this.type});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      child: Column(
        children: [
          _Title(
            title: title,
            subTitle: subtitle,
            type: type,
          ),
          Expanded(
              child: ListView.builder(
            itemCount: games.length,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return _Slide(
                game: games[index],
              );
            },
          ))
        ],
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String type;
  final String title;
  final String subTitle;
  const _Title(
      {required this.title, required this.subTitle, required this.type});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          CustomTextFont(
              text: title,
              fontSize: 18,
              color: colors.onBackground,
              fontWeight: FontWeight.bold),
          const Spacer(),
          TextButton(
              onPressed: () => context.push('/view_all_games_screen/$type'),
              child: CustomTextFont(
                  text: subTitle,
                  fontSize: 18,
                  color: colors.onBackground,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Game game;
  const _Slide({required this.game});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ImageWithTitle(game: game),
          SizedBox(
            width: 350,
            height: 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 280,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: colors.primary),
                            height: 25,
                            width: 120,
                            child: CustomTextFont(
                                text: game.genre,
                                fontSize: 15,
                                color: colors.onPrimary,
                                fontWeight: FontWeight.normal)),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextFont(
                            text: game.developer,
                            fontSize: 15,
                            color: colors.onBackground,
                            fontWeight: FontWeight.normal),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: Icon(
                      game.platform == 'PC (Windows)'
                          ? Icons.laptop_windows
                          : Icons.web,
                      color: colors.onBackground,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageWithTitle extends StatelessWidget {
  const _ImageWithTitle({
    required this.game,
  });

  final Game game;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 365,
      height: 206,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            game.thumbnail,
            fit: BoxFit.cover,
            width: 365,
            height: 206,
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
              return GestureDetector(
                onTap: () => context.push('/game_details_screen/${game.id}'),
                child: Stack(
                  children: [
                    FadeIn(child: child),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                          child: Container(
                            color: Colors.black26,
                            alignment: Alignment.center,
                            width: 340,
                            height: 30,
                            child: Stack(
                              children: [
                                Positioned(
                                    top: 5,
                                    left: 10,
                                    child: CustomTextFont(
                                        text: game.title,
                                        fontSize: 15,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          )),
    );
  }
}
