class ToDo {
  String? id;
  String? tarefaTxt;
  bool isDone;

  ToDo({required this.id, required this.tarefaTxt, this.isDone = false});

  static List<ToDo> listaTarefas() {
    return [
      //ToDo(id: '01', tarefaTxt: 'Estudar Flutter', isDone: true),
      //ToDo(id: '02', tarefaTxt: 'Assistir aula de Cálculo'),
      //ToDo(id: '03', tarefaTxt: 'Ir para a academia', isDone: true),
      //ToDo(id: '04', tarefaTxt: 'Revisar Regras de Inferência'),
      //ToDo(id: '05', tarefaTxt: 'Arrumar o quarto'),
    ];
  }
}
