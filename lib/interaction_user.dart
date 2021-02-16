import 'package:flutter/material.dart';

void main() {
  runApp(UserInteraction());
}

class UserInteraction extends StatefulWidget {
  @override
  _UserInteractionState createState() => _UserInteractionState();
}

class _UserInteractionState extends State<UserInteraction> {
  var textController = TextEditingController();
  List<String> todos = [];

  void addTodo(String todo) {
    todos.add(todo);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('User Interaction'),
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Add',
          key: ValueKey('floating'),
          child: Icon(Icons.add),
          onPressed: () {
            setState(() {
              addTodo(textController.text);
              textController.clear();
            });
          },
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                child: TextFormField(
                  key: ValueKey('enterText'),
                  controller: textController,
                  decoration: InputDecoration(hintText: 'Digite aqui'),
                ),
              ),
              SizedBox(height: 60),
              Column(
                  key: ValueKey('todoList'),
                  children: todos.map((e) {
                    return Dismissible(
                      child: Container(
                        margin: const EdgeInsets.all(8.0),
                        padding: const EdgeInsets.all(8.0),
                        color: Colors.red,
                        child: Text(e),
                      ),
                      // confirmDismiss: (_) async => false, // Descomentar quebra o teste de remover por deslize
                      onDismissed: (_) {},
                      key: ValueKey('$e${todos.indexOf(e)}'),
                    );
                  }).toList())
            ],
          ),
        ),
      ),
    );
  }
}
