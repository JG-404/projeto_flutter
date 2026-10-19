import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:projeto_flutter/model/monitor.dart';
import 'package:http/http.dart' as http;

class MonitorRepository{
  Future<List<Monitor>>getMonitores() async{
    final String url = "https://api.mockfly.dev/mocks/b71e1f34-3cf9-41f8-a45f-1096276f9d69/monitores";
    List<Monitor> monitores = [];

    try{
      final res = await http.get(Uri.parse(url));

      if (res.statusCode == 200){
        final data = jsonDecode(res.body);

        for (var monitor in data){
          monitores.add(Monitor.fromJson(monitor));
        }

        return monitores;
      }
      else{
        debugPrint("Erro de rquisição: ${res.statusCode}");
        return [];
      }
    }
    catch(error){
      debugPrint("Erro de servidor: $error");
      return [];
    }
  }
}