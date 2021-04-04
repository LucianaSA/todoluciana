import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todoluciana/core/repositories/tarefa/tarefa_repository_impl.dart';
import 'package:todoluciana/models/tarefa.dart';
import 'package:todoluciana/pages/cadastro/cadastro_page.dart';
import 'package:todoluciana/pages/home/home_controller.dart';
import 'package:todoluciana/pages/home/widgets/item_lista_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Isso gera acoplamento, vamos fazer com injeção de dependências.
  final HomeController controller = HomeController(
    TarefaRepositoryImpl(FirebaseFirestore.instance),
  );

  @override
  void initState() {
    super.initState();
    controller.listarTarefas();
  }

  @override
  Widget build(BuildContext context) {
    print('Passou pelo construtor');
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO LUCIANA'),
      ),
      body: ValueListenableBuilder(
        builder: (_, __, ___) {
          return ListView.builder(
            itemCount: controller.tarefas.value.length,
            itemBuilder: (context, index) => ItemListaWidget(
              tarefa: controller.tarefas.value[index],
            ),
          );
        },
        valueListenable: controller.tarefas,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          Tarefa? tarefa = await Navigator.of(context).push<Tarefa>(
            MaterialPageRoute(builder: (context) {
              return CadastroPage();
            }),
          );
        },
      ),
    );
  }
}
