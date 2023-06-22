import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:videogames/domain/entities/news.dart';
import 'package:videogames/presentation/providers/news/news_repository_provider.dart';

final newsProvider = StateNotifierProvider<NewsNotifier, List<News>>((ref) {
  final getNews = ref.watch(newsRepositoryProvider).getLatestnews;
  return NewsNotifier(getNews: getNews);
});

typedef NewsCallback = Future<List<News>> Function();

class NewsNotifier extends StateNotifier<List<News>> {
  NewsCallback getNews;

  NewsNotifier({required this.getNews}) : super([]);
  Future<void> loadNews() async {
    final List<News> news = await getNews();
    state = [...state, ...news];
  }
}