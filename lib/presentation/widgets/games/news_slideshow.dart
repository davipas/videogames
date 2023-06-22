import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:videogames/domain/entities/news.dart';
import 'package:videogames/presentation/screens/news_screens/details_news_screen.dart';
import 'package:videogames/presentation/widgets/widgets.dart';

class NewsSlideshow extends StatelessWidget {
  final List<News> news;
  const NewsSlideshow({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Swiper(
        pagination: SwiperPagination(
            margin: const EdgeInsets.only(top: 0),
            builder: DotSwiperPaginationBuilder(
                activeColor: colors.primary, color: colors.secondary)),
        viewportFraction: 0.9,
        scale: 0.9,
        itemCount: news.length,
        itemBuilder: (context, index) {
          return _Slide(news: news[index]);
        },
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final News news;
  const _Slide({required this.news});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;
    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: colors.onBackground,
              blurRadius: 2,
              offset: const Offset(0, 1))
        ]);
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
          decoration: decoration,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                news.mainImage,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress != null) {
                    return DecoratedBox(
                        decoration: BoxDecoration(color: colors.onBackground));
                  }
                  return GestureDetector(
                    onTap: () => context.pushNamed(DetailsNewsScreen.name,extra:news ),
                    child: Stack(
                      children: [
                        SizedBox.expand(child: FadeIn(child: child)),
                        const SizedBox.expand(
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    stops: [0.0, 0.7],
                                    colors: [Colors.black, Colors.transparent])),
                          ),
                        ),
                        Positioned(
                            bottom: 0,
                            left: size.width * 0.15,
                            child: SizedBox(
                              height: 60,
                              width: 300,
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CustomTextFont(
                                  text: news.title,
                                  fontSize: 13,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ))
                      ],
                    ),
                  );
                },
              ))),
    );
  }
}
