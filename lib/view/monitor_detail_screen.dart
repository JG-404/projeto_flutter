
import 'package:flutter/material.dart';

import 'package:projeto_flutter/model/monitor.dart';

class MonitorDetailScreen extends StatelessWidget {
  final Monitor monitor;
  final String dia;

  const MonitorDetailScreen({
    super.key,
    required this.monitor,
    required this.dia,
  });

  static const Map<String, String> dias = {
    'Segunda': 'segunda',
    'Terça': 'terca',
    'Quarta': 'quarta',
    'Quinta': 'quinta',
    'Sexta': 'sexta',
    'Sábado': 'sabado',
  };

  static const Map<String, String> nomesDias = {
    'segunda': 'Segunda-feira',
    'terca': 'Terça-feira',
    'quarta': 'Quarta-feira',
    'quinta': 'Quinta-feira',
    'sexta': 'Sexta-feira',
    'sabado': 'Sábado',
  };

  @override
  Widget build(BuildContext context) {
    final List<String> diasExibidos;

    if (dia == 'Todos') {
      diasExibidos = monitor.horarios.keys.toList();
    } else {
      final chaveDia = dias[dia];
      diasExibidos =
          chaveDia == null ? [] : [chaveDia];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(monitor.nome),
      ),

      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Center(
            child: ClipOval(
              child: Image.network(
                monitor.foto,
                width: 130,
                height: 130,
                fit: BoxFit.cover,
                webHtmlElementStrategy: WebHtmlElementStrategy.fallback,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint('Erro ao carregar foto: $error');

                  return const SizedBox(
                    width: 130,
                    height: 130,
                    child: Icon(Icons.person, size: 65),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 20),

          Text(
            monitor.nome,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),

          const Text(
            'Horários de atendimento',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          for (final chaveDia in diasExibidos)
            if (monitor.horarios[chaveDia]?.isNotEmpty ?? false)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        nomesDias[chaveDia] ?? chaveDia,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),

                      for (final horario
                          in monitor.horarios[chaveDia]!)
                        Padding(
                          padding:
                              const EdgeInsets.only(bottom: 6),
                          child: Text(horario),
                        ),
                    ],
                  ),
                ),
              ),

          if (diasExibidos.isEmpty ||
              !diasExibidos.any(
                (chave) =>
                    monitor.horarios[chave]?.isNotEmpty ??
                    false,
              ))
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Nenhum horário cadastrado para esta opção.',
                textAlign: TextAlign.center,
              ),
            ),
        ],
      ),
    );
  }
}
