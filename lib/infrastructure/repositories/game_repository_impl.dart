import 'package:videogames/domain/datasources/games_datasource.dart';
import 'package:videogames/domain/entities/game.dart';
import 'package:videogames/domain/entities/game_by_id.dart';
import 'package:videogames/domain/repositories/games_repository.dart';

class GameRepositoryImpl extends GamesRepository {
  final GamesDatasource datasource;

  GameRepositoryImpl(this.datasource);

  @override
  Future<List<Game>> getGames() {
    return datasource.getGames();
  }

  @override
  Future<List<Game>> getGamesAlphabetically() {
    return datasource.getGamesAlphabetically();
  }

  @override
  Future<List<Game>> getGamesLatest() {
    return datasource.getGamesLatest();
  }

  @override
  Future<List<Game>> getGamesPopular() {
    return datasource.getGamesPopular();
  }

  @override
  Future<GameById> getGameById(String gameId) {
    return datasource.getGameById(gameId);
  }
}
