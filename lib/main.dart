import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projeto_flutter/router/app_router.dart';
import 'package:projeto_flutter/repository/monitor_repository.dart';
import 'package:projeto_flutter/view_model/home_screen_view_model.dart';
import 'package:projeto_flutter/view_model/monitor_view_model.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeScreenViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => MonitorViewModel(
            MonitorRepository(),
          )..carregarMonitores(),
        ),
      ],
      child: const MonitorApp(),
    ),
  );
}

class MonitorApp extends StatelessWidget {
  const MonitorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Monitores DCOMP',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 230, 40, 230),
        ),
      ),
      routerConfig: appRouter,
    );
  }
}
