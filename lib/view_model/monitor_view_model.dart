import 'package:flutter/foundation.dart';
import 'package:projeto_flutter/model/monitor.dart';
import 'package:projeto_flutter/repository/monitor_repository.dart';

class MonitorViewModel extends ChangeNotifier {
  final MonitorRepository _repository;

  MonitorViewModel(this._repository);

  List<Monitor> _monitores = [];
  bool _carregando = false;
  String? _erro;

  List<Monitor> get monitores => _monitores;
  bool get carregando => _carregando;
  String? get erro => _erro;

  Future<void> carregarMonitores() async {
    _carregando = true;
    _erro = null;
    notifyListeners();

    try {
      _monitores = await _repository.getMonitores();
    } catch (e) {
      _erro = 'Não foi possível carregar os monitores.';
      debugPrint('Erro ao carregar monitores: $e');
    } finally {
      _carregando = false;
      notifyListeners();
    }
  }

  List<Monitor> temDia(String dia) {
    if (dia == 'Todos' || dia.isEmpty) {
      return _monitores;
    }

    final Map<String, String> dias = {
      'Segunda': 'segunda',
      'Terça': 'terca',
      'Quarta': 'quarta',
      'Quinta': 'quinta',
      'Sexta': 'sexta',
      'Sábado': 'sabado',
    };

    final String? chaveDia = dias[dia];

    if (chaveDia == null) {
      return [];
    }

    List<Monitor> filtrados = [];

    for (Monitor monitor in _monitores) {
      final horarios = monitor.horarios[chaveDia];

      if (horarios != null && horarios.isNotEmpty) {
        filtrados.add(monitor);
      }
    }

    return filtrados;
  }
}
