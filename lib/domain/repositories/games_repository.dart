import 'package:videogames/domain/entities/game.dart';
import 'package:videogames/domain/entities/game_by_id.dart';

abstract class GamesRepository {
  Future<List<Game>> getGames();
  Future<List<Game>> getGamesAlphabetically();
  Future<List<Game>> getGamesPopular();
  Future<List<Game>> getGamesLatest();
  Future<GameById> getGameById(String gameId);
}
