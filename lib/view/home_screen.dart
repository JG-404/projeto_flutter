
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:projeto_flutter/view_model/home_screen_view_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeScreenViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Monitores DCOMP'),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 230, 40, 230),
              ),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  'Encontre seu monitor',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            for (final opcao in viewModel.opcoes)
              ListTile(
                title: Text(opcao),
                selected: viewModel.selecionado == opcao,
                onTap: () {
                  viewModel.selecionar(opcao);

                  Navigator.pop(context);

                  context.push(
                    '/carrossel',
                    extra: opcao,
                  );
                },
              ),
          ],
        ),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.school_outlined,
                size: 76,
                color: Color.fromARGB(255, 230, 40, 230),
              ),
              const SizedBox(height: 24),
              const Text(
                'Seus estudos, no caminho certo.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'Descubra os horários dos monitores '
                'do DCOMP e encontre o melhor momento '
                'para tirar suas dúvidas.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 28),
              const Text(
                'Abra o menu e escolha um dia para começar.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
