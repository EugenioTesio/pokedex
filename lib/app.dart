import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pokedex/core/constants/theme.dart';
import 'package:pokedex/core/routing/app_router.dart';
import 'package:pokedex/features/dark_mode/presentation/providers/dark_mode_controller.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouter = ref.watch(goRouterProvider);
    final darkMode = ref.watch(darkModeProvider);
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: lightTheme,
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      darkTheme: darkTheme,
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => 'Pokedex',
    );
  }
}
