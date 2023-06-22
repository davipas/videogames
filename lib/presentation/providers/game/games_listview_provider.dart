import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:videogames/domain/entities/game.dart';
import 'package:videogames/presentation/providers/game/games_provider.dart';

final gamesListviewShowProvider = Provider<List<Game>>((ref) {
  final games = ref.watch(gamesProvider);
  if (games.isEmpty) return [];
  return games.sublist(0, 10);
});
final gamesAlphabeticallyListviewShowProvider = Provider<List<Game>>((ref) {
  final games = ref.watch(gamesAlphabeticallyProvider);
  if (games.isEmpty) return [];
  return games.sublist(0, 10);
});
final gamesPopularListviewShowProvider = Provider<List<Game>>((ref) {
  final games = ref.watch(gamesPopularProvider);
  if (games.isEmpty) return [];
  return games.sublist(0, 10);
});
final gamesLatestListviewShowProvider = Provider<List<Game>>((ref) {
  final games = ref.watch(gamesLatestProvider);
  if (games.isEmpty) return [];
  return games.sublist(0, 10);
});

