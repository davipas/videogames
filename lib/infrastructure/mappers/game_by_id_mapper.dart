import 'package:videogames/domain/entities/game_by_id.dart';
import 'package:videogames/infrastructure/models/mmobomb/game_by_id_mmobomb.dart';

class GameByIdMapper {
  static GameById gameByIdToEntity(GameByIdMmobomb gameByIdMmobomb) => GameById(
      id: gameByIdMmobomb.id,
      title: gameByIdMmobomb.title,
      thumbnail: gameByIdMmobomb.thumbnail,
      status: gameByIdMmobomb.status,
      shortDescription: gameByIdMmobomb.shortDescription,
      description: gameByIdMmobomb.description,
      gameUrl: gameByIdMmobomb.gameUrl,
      genre: gameByIdMmobomb.genre,
      platform: gameByIdMmobomb.platform,
      publisher: gameByIdMmobomb.publisher,
      developer: gameByIdMmobomb.developer,
      releaseDate: gameByIdMmobomb.releaseDate,
      profileUrl: gameByIdMmobomb.profileUrl,
      minimumSystemRequirements: MinimumSystemRequirements(
          os: gameByIdMmobomb.minimumSystemRequirements.os,
          processor: gameByIdMmobomb.minimumSystemRequirements.processor,
          memory: gameByIdMmobomb.minimumSystemRequirements.memory,
          graphics: gameByIdMmobomb.minimumSystemRequirements.graphics,
          storage: gameByIdMmobomb.minimumSystemRequirements.storage),
      screenshots: gameByIdMmobomb.screenshots
          .map((screenshotMmobomb) =>
              ScreenshotsMapper.screenshotToEntity(screenshotMmobomb))
          .toList());
}

class ScreenshotsMapper {
  static Screenshot screenshotToEntity(ScreenshotMmobomb screenshotMmobomb) =>
      Screenshot(id: screenshotMmobomb.id, image: screenshotMmobomb.image);
}
