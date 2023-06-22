import 'package:videogames/domain/entities/news.dart';

abstract class NewsDatasource {
  Future<List<News>> getLatestnews();
}
