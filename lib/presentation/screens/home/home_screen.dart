import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:videogames/presentation/providers/providers.dart';
import 'package:videogames/presentation/screens/screens.dart';
import 'package:videogames/presentation/widgets/widgets.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  User? user;
  UserContextGoogle? userContextGoogle;
  static const String name = 'home_screen';
  HomeScreen({this.userContextGoogle, this.user, super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colors.background,
      body: _HomeView(
        user: userContextGoogle?.user,
        auth: userContextGoogle?.auth,
        googleSignIn: userContextGoogle?.googleSignIn,
        userFirebase: user,
      ),
      // bottomNavigationBar: const CustomBottomNavigation(),
    );
  }
}

// ignore: must_be_immutable
class _HomeView extends ConsumerStatefulWidget {
  User? userFirebase;
  User? user;
  final FirebaseAuth? auth;
  final GoogleSignIn? googleSignIn;
  _HomeView({this.userFirebase, this.user, this.auth, this.googleSignIn});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(gamesProvider.notifier).loadGames();
    ref.read(gamesAlphabeticallyProvider.notifier).loadGames();
    ref.read(gamesPopularProvider.notifier).loadGames();
    ref.read(gamesLatestProvider.notifier).loadGames();
    ref.read(newsProvider.notifier).loadNews();
  }

  @override
  Widget build(BuildContext context) {
    //Funcion para cerrar sesión
    cerrarSesion() async {
      if (widget.googleSignIn == null) {
        FirebaseAuth.instance.signOut();
        ref.read(userFirebaseProvider.notifier).update((state) => null);
        context.goNamed(WelcomeScreen.name);
      } else {
        try {
          await widget.auth?.signOut();
          if (await widget.googleSignIn!.isSignedIn()) {
            await widget.googleSignIn?.signOut();
            ref.read(userGoogleProvider.notifier).update((state) => null);
            // ignore: use_build_context_synchronously
            context.goNamed(WelcomeScreen.name);
          }
        } catch (e) {
          // ignore: avoid_print
          print(e);
        }
      }
    }
    final colors = Theme.of(context).colorScheme;
    final games = ref.watch(gamesListviewShowProvider);
    final gamesAlphabetically =
        ref.watch(gamesAlphabeticallyListviewShowProvider);
    final gamesPopular = ref.watch(gamesPopularListviewShowProvider);
    final gamesLatest = ref.watch(gamesLatestListviewShowProvider);
    final news = ref.watch(newsSliderShowProvider);
    final user = ref.watch(userGoogleProvider);
    final userFirebase = ref.watch(userFirebaseProvider);
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: CustomAppbar(),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: colors.primaryContainer),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          user?.photoURL ??
                              'https://i.pinimg.com/474x/3d/27/c1/3d27c1d91548b66bbe4d0610d9515615.jpg',
                          height: 35,
                          width: 35,
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      CustomTextFont(
                          // text: 'Bienvenido ${user?.displayName ?? 'usuario'}',
                          text:userFirebase == null
                          ?'Bienvenido: ${user?.displayName ?? 'usuario'}'
                          :'Email: ${userFirebase.email ?? 'No hay correo'}',
                          fontSize: 20,
                          color: colors.onPrimaryContainer,
                          fontWeight: FontWeight.bold),
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            cerrarSesion();
                          },
                          icon: const Icon(Icons.logout_outlined))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    CustomTextFont(
                        text: 'Noticias Gamer',
                        fontSize: 30,
                        color: colors.onBackground,
                        fontWeight: FontWeight.w100),
                    const Spacer(),
                    TextButton(
                        onPressed: () {
                          context.pushNamed(ViewAllNewsScreen.name);
                        },
                        child: CustomTextFont(
                            text: 'Ver todas',
                            fontSize: 18,
                            color: colors.onBackground,
                            fontWeight: FontWeight.bold))
                  ],
                ),
              ),
              NewsSlideshow(news: news),
              GameHorizontalListview(
                games: games,
                title: 'Juegos Relevantes',
                subtitle: 'Ver todas',
                type: 'relevantes',
              ),
              GameHorizontalListview(
                games: gamesAlphabetically,
                title: 'Juegos de la A - Z',
                subtitle: 'Ver todas',
                type: 'ordenados',
              ),
              GameHorizontalListview(
                games: gamesPopular,
                title: 'Juegos Populares',
                subtitle: 'Ver todas',
                type: 'populares',
              ),
              GameHorizontalListview(
                games: gamesLatest,
                title: 'Los ultimos!',
                subtitle: 'Ver todas',
                type: 'ultimos',
              ),
            ],
          );
        }, childCount: 1))
      ],
    );
  }
}
