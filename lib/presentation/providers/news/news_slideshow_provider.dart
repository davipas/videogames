import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:videogames/domain/entities/news.dart';
import 'package:videogames/presentation/providers/news/news_provider.dart';

final newsSliderShowProvider = Provider<List<News>>((ref) {
  final news = ref.watch(newsProvider);
  if (news.isEmpty) return [];
  return news.sublist(0, 5);
});
