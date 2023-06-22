import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:videogames/domain/entities/game.dart';
import 'package:videogames/presentation/providers/game/games_provider.dart';

final gamesSliderShowProvider = Provider<List<Game>>((ref) {
  final games = ref.watch(gamesProvider);
  if (games.isEmpty) return [];
  return games.sublist(0, 10);
});
