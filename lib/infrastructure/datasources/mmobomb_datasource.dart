import 'package:dio/dio.dart';
import 'package:videogames/domain/datasources/games_datasource.dart';
import 'package:videogames/domain/entities/game.dart';
import 'package:videogames/domain/entities/game_by_id.dart';
import 'package:videogames/infrastructure/mappers/game_by_id_mapper.dart';
import 'package:videogames/infrastructure/mappers/game_mapper.dart';
import 'package:videogames/infrastructure/models/mmobomb/game_by_id_mmobomb.dart';
import 'package:videogames/infrastructure/models/mmobomb/game_mmobomb.dart';

class MmobombDatasource extends GamesDatasource {
  final dio = Dio(BaseOptions(baseUrl: 'https://www.mmobomb.com/api1'));

  @override
  Future<List<Game>> getGames() async {
    final response = await dio.get('/games');
    final List<dynamic> responseData = response.data;

    final List<Game> games = responseData.map((gameData) {
      final mmobombResponse = GameMmobomb.fromJson(gameData);
      return GameMapper.mmobombToEntity(mmobombResponse);
    }).toList();
    return games;
  }

  @override
  Future<List<Game>> getGamesAlphabetically() async {
    final response =
        await dio.get('/games', queryParameters: {'sort-by': 'alphabetical'});
    final List<dynamic> responseData = response.data;

    final List<Game> games = responseData.map((gameData) {
      final mmobombResponse = GameMmobomb.fromJson(gameData);
      return GameMapper.mmobombToEntity(mmobombResponse);
    }).toList();
    return games;
  }

  @override
  Future<List<Game>> getGamesLatest() async {
    final response =
        await dio.get('/games', queryParameters: {'sort-by': 'release-date'});
    final List<dynamic> responseData = response.data;

    final List<Game> games = responseData.map((gameData) {
      final mmobombResponse = GameMmobomb.fromJson(gameData);
      return GameMapper.mmobombToEntity(mmobombResponse);
    }).toList();
    return games;
  }

  @override
  Future<List<Game>> getGamesPopular() async {
    final response =
        await dio.get('/games', queryParameters: {'sort-by': 'popularity'});
    final List<dynamic> responseData = response.data;

    final List<Game> games = responseData.map((gameData) {
      final mmobombResponse = GameMmobomb.fromJson(gameData);
      return GameMapper.mmobombToEntity(mmobombResponse);
    }).toList();
    return games;
  }

  @override
  Future<GameById> getGameById(String gameId) async {
    final response = await dio.get('/game', queryParameters: {'id': gameId});
    final gameDetails = GameByIdMmobomb.fromJson(response.data);
    final GameById game = GameByIdMapper.gameByIdToEntity(gameDetails);
    return game;
  }
}
