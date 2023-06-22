import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:videogames/domain/entities/news.dart';
import 'package:videogames/presentation/screens/login/user_context_google.dart';
import 'package:videogames/presentation/screens/screens.dart';

final appRouter = GoRouter(initialLocation: '/welcome', routes: [
  GoRoute(
      path: '/home_screen',
      name: HomeScreen.name,
      builder: (context, state) {
        if(state.extra is UserContextGoogle){
          final userContextGoogle = state.extra as UserContextGoogle;
          return HomeScreen(
          userContextGoogle: userContextGoogle,
        );
        }else{
        final user = state.extra as User;
        return HomeScreen(
          user:user
        );
        }
      }),
  GoRoute(
    path: '/details_news_screen',
    name: DetailsNewsScreen.name,
    builder: (context, state) {
      final news = state.extra as News;
      return DetailsNewsScreen(news: news);
    },
  ),
  GoRoute(
      path: '/view_all_news_screen',
      name: ViewAllNewsScreen.name,
      builder: (context, state) => const ViewAllNewsScreen()),
  // GoRoute(
  //   path: '/view_all_games_screen',
  //   name: ViewAllGamesScreen.name,
  //   builder: (context, state) {
  //     final List<Game> games= state.extra as List<Game>;
  //     return ViewAllGamesScreen(games: games,);
  //   }
  // ),
  GoRoute(
      path: '/view_all_games_screen/:type',
      name: ViewAllGamesScreen.name,
      builder: (context, state) {
        final type = state.pathParameters['type'] ?? 'populares';
        return ViewAllGamesScreen(type: type);
      }),
  GoRoute(
      path: '/game_details_screen/:id',
      name: GameDetailsScreen.name,
      builder: (context, state) {
        final id = state.pathParameters['id'] ?? 'no-id';
        return GameDetailsScreen(id: id);
      }),
  GoRoute(
    name: ConfigScreen.name,
    path: '/config_screen',
    builder: (context, state) => const ConfigScreen(),
  ),
  GoRoute(
    path: '/welcome',
    name: WelcomeScreen.name,
    builder: (context, state) => const WelcomeScreen(),
  ),
  GoRoute(
    path: '/login',
    name: LoginScreen.name,
    builder: (context, state) => const LoginScreen(),
  ),
  GoRoute(
    path: '/register',
    name: RegisterScreen.name,
    builder: (context, state) => const RegisterScreen(),
  ),
]);
