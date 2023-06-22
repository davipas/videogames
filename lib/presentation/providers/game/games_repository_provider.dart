import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:videogames/infrastructure/datasources/mmobomb_datasource.dart';
import 'package:videogames/infrastructure/repositories/game_repository_impl.dart';

final gamesRepositoryProvider = Provider((ref) {
  return GameRepositoryImpl(MmobombDatasource());
});
