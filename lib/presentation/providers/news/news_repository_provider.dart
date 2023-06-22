import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:videogames/infrastructure/datasources/news_mmobomb_datasource.dart';
import 'package:videogames/infrastructure/repositories/news_repository_impl.dart';

final newsRepositoryProvider = Provider((ref) {
  return NewsRepositoryImpl(NewsMmobombDatasource());
});
