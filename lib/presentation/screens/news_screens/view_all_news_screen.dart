import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:videogames/domain/entities/news.dart';
import 'package:videogames/presentation/providers/news/news_provider.dart';
import 'package:videogames/presentation/screens/screens.dart';
import 'package:videogames/presentation/widgets/shared/custom_text_font.dart';

class ViewAllNewsScreen extends ConsumerWidget {
  static const String name = 'view_all_news_screen';
  const ViewAllNewsScreen({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final colors = Theme.of(context).colorScheme;
    final news = ref.watch(newsProvider);

    return Scaffold(
      appBar: AppBar(title: CustomTextFont(text: 'Todas las Noticias', fontSize: 30, color: colors.onBackground, fontWeight: FontWeight.bold),),
      body: ListView.builder(
      itemCount: news.length,
      itemBuilder: (context, index) {
        return _CustomCard(
          news: news[index],
        );
      },
    ));
  }
}

class _CustomCard extends StatelessWidget {
  final News news;
  const _CustomCard({required this.news});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      // color: colors.primary,
      child: InkWell(
        onTap: () => context.pushNamed(DetailsNewsScreen.name,extra:news ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(30),topRight: Radius.circular(30)),
              child: Image.network(
                news.mainImage,
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
            ),
            CustomTextFont(
                text: news.title,
                fontSize: 20,
                color: colors.onBackground,
                fontWeight: FontWeight.bold),
            CustomTextFont(
              text: news.shortDescription,
              fontSize: 15,
              color: colors.primary,
              fontWeight: FontWeight.w100,
              maxLines: 5,
            ),
            const SizedBox(height: 20,)
          ],
        ),
      ),
    );
  }
}
