import 'package:videogames/domain/entities/news.dart';

abstract class NewsRepository {
  Future<List<News>> getLatestnews();
}
