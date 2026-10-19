import 'package:flutter/foundation.dart';

class HomeScreenViewModel extends ChangeNotifier {
  static const List<String> _opcoes = [
  'Segunda',
  'Terça',
  'Quarta',
  'Quinta',
  'Sexta',
  'Sábado',
  'Todos',
  ];

  String? _selecionado;

  List<String> get opcoes => _opcoes;

  String? get selecionado => _selecionado;

  bool get temSelecao => _selecionado != null;

  bool get mostrarTodos => _selecionado == 'Todos';

  String get titulo => _selecionado ?? 'Monitores DCOMP';

  void selecionar(String opcao) {
    if (!_opcoes.contains(opcao)) return;

    if (_selecionado == opcao) return;

    _selecionado = opcao;

    notifyListeners();
  }
}
