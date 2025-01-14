import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:socials/components/Custom/constants.dart';
import 'package:socials/components/Pages/RoutingErrorPage.dart';
import 'package:socials/components/Pages/home.dart';
import 'package:socials/components/Pages/login.dart';
import 'package:socials/components/Pages/signup.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    ColorSelection colorSelected = ColorSelection.blue;
    final GoRouter _router = GoRouter(routes: [
      GoRoute(path: '/', builder: (context, state) => const Login()),
      GoRoute(
          path: '/notfound',
          builder: (context, state) => const Routingerrorpage()),
      GoRoute(path: '/signup', builder: (context, state) => const Signup()),
      GoRoute(path: '/home', builder: (context, state) => const Home())
    ], initialLocation: '/');
    return ShadApp.router(
      title: "Socials",
      themeMode: ThemeMode.light,
      theme: ShadThemeData(
        brightness: Brightness.light,
        colorScheme: const ShadZincColorScheme.light(),
      ),
      darkTheme: ShadThemeData(
        brightness: Brightness.dark,
        colorScheme: const ShadZincColorScheme.dark(),
      ),
      routerConfig: _router,
    );
  }
}
