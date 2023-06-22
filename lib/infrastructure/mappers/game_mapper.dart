
import 'package:videogames/domain/entities/game.dart';
import 'package:videogames/infrastructure/models/mmobomb/game_mmobomb.dart';

class GameMapper {
  static Game mmobombToEntity(GameMmobomb gameMmobomb) => Game(
      id: gameMmobomb.id,
      title: gameMmobomb.title,
      thumbnail: gameMmobomb.thumbnail,
      shortDescription: gameMmobomb.shortDescription,
      gameUrl: gameMmobomb.gameUrl,
      genre: gameMmobomb.genre,
      platform: gameMmobomb.platform,
      publisher: gameMmobomb.publisher,
      developer: gameMmobomb.developer,
      releaseDate: gameMmobomb.releaseDate,
      profileUrl: gameMmobomb.profileUrl);
}
