import 'package:flutter/material.dart';
import 'package:todoluciana/core/repositories/tarefa/tarefa_repository.dart';
import 'package:todoluciana/models/tarefa.dart';

class HomeController {
  final TarefaRepository repository;
  final ValueNotifier<List<Tarefa>> tarefas = ValueNotifier([]);

  HomeController(this.repository);

  adicionarTarefas(Tarefa tarefa) {
    tarefas.value.add(tarefa);
    tarefas.notifyListeners();
  }

  listarTarefas() async {
    tarefas.value = await repository.listar();
    tarefas.notifyListeners();
  }
}
