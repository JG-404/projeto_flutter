import 'package:flutter/material.dart';
import 'package:projeto_flutter/view_model/monitor_view_model.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:projeto_flutter/model/monitor.dart';
import 'package:flutter/gestures.dart';

class CarouselScreen extends StatefulWidget {
  final String dia;

  const CarouselScreen({
    super.key,
    required this.dia,
  });

  @override
  State<CarouselScreen> createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      initialPage: 1000,
      viewportFraction: 0.78,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MonitorViewModel>();
    final List<Monitor> monitores = viewModel.temDia(widget.dia);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.dia == 'Todos'
              ? 'Todos os monitores'
              : 'Monitores de ${widget.dia}',
        ),
        centerTitle: true,
      ),
      body: Builder(
        builder: (context) {
          if (viewModel.carregando) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (viewModel.erro != null) {
            return Center(
              child: Text(viewModel.erro!),
            );
          }

          if (monitores.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum monitor encontrado para este dia.',
                textAlign: TextAlign.center,
              ),
            );
          }

          return Column(
            children: [
              const SizedBox(height: 24),

              const Text(
                'Deslize para explorar os monitores',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 16),

              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  scrollBehavior: const MaterialScrollBehavior().copyWith(
                    dragDevices: {
                      PointerDeviceKind.touch,
                      PointerDeviceKind.mouse,
                      PointerDeviceKind.trackpad,
                    },
                  ),
                  itemBuilder: (context, index) {
                    final int indiceReal =
                        index % monitores.length;

                    final Monitor monitor =
                        monitores[indiceReal];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 20,
                      ),
                      child: Card(
                        elevation: 4,
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: InkWell(
                          onTap: () {
                            context.push(
                              '/detalhes',
                              extra: {
                                'monitor': monitor,
                                'dia': widget.dia,
                              },
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.center,
                              children: [
                                ClipOval(
                                  child: Image.network(
                                    monitor.foto,
                                    width: 110,
                                    height: 110,
                                    fit: BoxFit.cover,
                                    webHtmlElementStrategy: WebHtmlElementStrategy.fallback,
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }

                                      return const SizedBox(
                                        width: 110,
                                        height: 110,
                                        child: Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      debugPrint('Erro ao carregar foto: $error');

                                      return const SizedBox(
                                        width: 110,
                                        height: 110,
                                        child: Center(
                                          child: Icon(Icons.person, size: 60),
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                const SizedBox(height: 24),

                                Text(
                                  monitor.nome,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 12),

                                Text(
                                  widget.dia == 'Todos'
                                      ? 'Monitor'
                                      : 'Monitor de ${widget.dia}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey,
                                  ),
                                ),

                                const SizedBox(height: 24),

                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Text('Ver horários'),
                                    SizedBox(width: 8),
                                    Icon(Icons.arrow_forward),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }
}
