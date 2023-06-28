import 'package:flutter/material.dart';
import 'package:todolist/constantes/cores.dart';
import 'package:todolist/widgets/todo_item.dart';
import 'package:todolist/model/todo.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final tarefasLista = ToDo.listaTarefas();
  List<ToDo> _acharTarefa = [];
  final _tarefaController = TextEditingController();

  @override
  void initState() {
    _acharTarefa = tarefasLista;
    super.initState();
  }

  void _runFilter(String palavraChave) {
    List<ToDo> results = [];
    if (palavraChave.isEmpty) {
      results = tarefasLista;
    } else {
      results = tarefasLista
          .where((item) => item.tarefaTxt!
              .toLowerCase()
              .contains(palavraChave.toLowerCase()))
          .toList();
    }

    setState(() {
      _acharTarefa = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: tdBGColor,
        appBar: _buildAppBar(),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [
                  searchBox(),
                  Expanded(
                    child: ListView(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 50, bottom: 20),
                          child: const Text(
                            'Minhas tarefas',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500),
                          ),
                        ),
                        for (ToDo tarefa in _acharTarefa.reversed)
                          TodoItem(
                            tarefa: tarefa,
                            onToDoChanged: _handleToDoChange,
                            onDeleteItem: _deleteToDoItem,
                          )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Expanded(
                    child: Container(
                  margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 0.0),
                            blurRadius: 10.0,
                            spreadRadius: 2.0),
                      ],
                      borderRadius: BorderRadius.circular(20)),
                  child: TextField(
                    controller: _tarefaController,
                    decoration: InputDecoration(
                        hintText: 'Adicionar tarefa', border: InputBorder.none),
                  ),
                )),
                Container(
                    margin: EdgeInsets.only(
                      bottom: 20,
                      right: 20,
                    ),
                    child: ElevatedButton(
                      child: Text(
                        '+',
                        style: TextStyle(
                          fontSize: 40,
                        ),
                      ),
                      onPressed: () {
                        _addToDoItem(_tarefaController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        backgroundColor: tdBlue,
                        minimumSize: Size(60, 60),
                        elevation: 10,
                      ),
                    ))
              ]),
            )
          ],
        ));
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
    //todo.isDone = !todo.isDone;
  }

  void _deleteToDoItem(String id) {
    setState(() {
      tarefasLista.removeWhere((item) => item.id == id);
    });
  }

  void _addToDoItem(String tarefa) {
    setState(() {
      tarefasLista.add(ToDo(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          tarefaTxt: tarefa));
    });
    _tarefaController.clear();
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: TextField(
          onChanged: (value) => _runFilter(value),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(0),
              prefixIcon: Icon(
                Icons.search,
                color: tdBlack,
                size: 20,
              ),
              prefixIconConstraints:
                  BoxConstraints(maxHeight: 20, minWidth: 25),
              border: InputBorder.none,
              hintText: 'Pesquisar',
              hintStyle: TextStyle(color: tdGrey))),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
        backgroundColor: tdBGColor,
        elevation: 0,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Icon(
            Icons.menu,
            color: tdBlack,
            size: 30,
          ),
          Container(
            height: 40,
            width: 40,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/images/user.jpeg')),
          ),
        ]));
  }
}
