import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:videogames/domain/entities/game.dart';
import 'package:videogames/presentation/providers/game/games_repository_provider.dart';

final gamesProvider = StateNotifierProvider<GamesNotifier, List<Game>>((ref) {
  final getGames = ref.watch(gamesRepositoryProvider).getGames;
  return GamesNotifier(getGames: getGames);
});
final gamesAlphabeticallyProvider = StateNotifierProvider<GamesNotifier, List<Game>>((ref) {
  final getGames = ref.watch(gamesRepositoryProvider).getGamesAlphabetically;
  return GamesNotifier(getGames: getGames);
});
final gamesPopularProvider = StateNotifierProvider<GamesNotifier, List<Game>>((ref) {
  final getGames = ref.watch(gamesRepositoryProvider).getGamesPopular;
  return GamesNotifier(getGames: getGames);
});
final gamesLatestProvider = StateNotifierProvider<GamesNotifier, List<Game>>((ref) {
  final getGames = ref.watch(gamesRepositoryProvider).getGamesLatest;
  return GamesNotifier(getGames: getGames);
});

typedef GamesCallback = Future<List<Game>> Function();

class GamesNotifier extends StateNotifier<List<Game>> {
  GamesCallback getGames;

  GamesNotifier({required this.getGames}) : super([]);
  Future<void> loadGames() async {
    final List<Game> games = await getGames();
    state = [...state, ...games];
  }
}
