
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:videogames/domain/entities/game_by_id.dart';
import 'package:videogames/presentation/providers/game/games_repository_provider.dart';

final gameInfoProvider = StateNotifierProvider<GameByIdMapNotifier, Map<String,GameById>>((ref) {
  final gameRepository = ref.watch(gamesRepositoryProvider).getGameById;
  return GameByIdMapNotifier(getGame: gameRepository);
});

typedef GetGameCallback = Future<GameById> Function(String id);

class GameByIdMapNotifier extends StateNotifier<Map<String, GameById>> {
  final GetGameCallback getGame;

  GameByIdMapNotifier({
    required this.getGame,
  }) : super({});

  Future<void> loadGame(String id) async {
    // if (state[id] != null) return;
    final game = await getGame(id);
    state = {...state, id: game};
  }
}
