
import 'package:go_router/go_router.dart';
import 'package:projeto_flutter/view/splash_screen.dart';
import 'package:projeto_flutter/model/monitor.dart';
import 'package:projeto_flutter/view/home_screen.dart';
import 'package:projeto_flutter/view/carousel_screen.dart';
import 'package:projeto_flutter/view/monitor_detail_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) => const SplashScreen(),
    ),

    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),

    GoRoute(
      path: '/carrossel',
      builder: (context, state) {
        final dia = state.extra as String;

        return CarouselScreen(dia: dia);
      },
    ),

    GoRoute(
      path: '/detalhes',
      builder: (context, state) {
        final dados =
            state.extra as Map<String, dynamic>;

        return MonitorDetailScreen(
          monitor: dados['monitor'] as Monitor,
          dia: dados['dia'] as String,
        );
      },
    ),
  ],
);
