import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:videogames/domain/entities/news.dart';
import 'package:videogames/presentation/widgets/shared/custom_text_font.dart';

class DetailsNewsScreen extends StatelessWidget {
  final News news;
  static const String name = 'details_news_screen';
  const DetailsNewsScreen({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
        _CustomSliverAppBar(
          news: news,
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return _NewsDetails(
            news: news,
          );
        }, childCount: 1))
            ],
          ));
  }
}

class _NewsDetails extends StatelessWidget {
  final News news;
  const _NewsDetails({required this.news});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CustomTextFont(
              text: news.title,
              fontSize: 30,
              color: colors.primary,
              fontWeight: FontWeight.bold),
          const SizedBox(
            height: 20,
          ),
          CustomTextFont(
              text: news.shortDescription,
              fontSize: 20,
              color: colors.onBackground,
              fontWeight: FontWeight.w300),
          const SizedBox(
            height: 20,
          ),
          TextButton.icon(
            onPressed: () {
              final Uri url = Uri.parse(news.articleUrl);
              launchUrl(url);
            },
            icon: Icon(
              Icons.link,
              color: colors.onPrimary,
            ),
            label: CustomTextFont(
                text: 'Ver noticia',
                fontSize: 15,
                color: colors.onPrimary,
                fontWeight: FontWeight.w200),
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(colors.primary)),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomTextFont(
            text: news.articleContent,
            fontSize: 15,
            color: colors.primary,
            fontWeight: FontWeight.w100,
            maxLines: 30,
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }
}

class _CustomSliverAppBar extends StatelessWidget {
  final News news;
  const _CustomSliverAppBar({required this.news});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SliverAppBar(
      backgroundColor: Colors.black,
      expandedHeight: size.height * 0.7,
      foregroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        background: Stack(
          children: [
            SizedBox.expand(
              child: Image.network(
                news.mainImage,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) return const SizedBox();
                  return FadeIn(child: child);
                },
              ),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.6, 1.0],
                          colors: [Colors.transparent, Colors.black87]))),
            ),
            const SizedBox.expand(
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          stops: [0.0, 0.3],
                          colors: [Colors.black87, Colors.transparent]))),
            )
          ],
        ),
      ),
    );
  }
}
