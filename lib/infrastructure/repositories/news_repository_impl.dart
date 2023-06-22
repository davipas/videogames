import 'package:videogames/domain/datasources/news_datasource.dart';
import 'package:videogames/domain/entities/news.dart';
import 'package:videogames/domain/repositories/news_repository.dart';

class NewsRepositoryImpl extends NewsRepository {
  final NewsDatasource datasource;

  NewsRepositoryImpl(this.datasource);
  @override
  Future<List<News>> getLatestnews() {
    return datasource.getLatestnews();
  }
}
