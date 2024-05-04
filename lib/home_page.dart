import "package:flutter/material.dart";
import "todo_item.dart";


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<ToDoItem> _todoList = [];

  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void deleteCallback(ToDoItem i) {
    setState(() {
      _todoList.remove(i);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Список дел"),
      ),
      body: Container(
        margin: const EdgeInsets.only(
          top: 20,
        ),
        child: _todoList.isNotEmpty
            ? ListView.builder(
            itemCount: _todoList.length,
            itemBuilder: (BuildContext context, int index) =>
            _todoList[index])
            : const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.assignment),
              Text("Здесь будет ваш список дел"),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text("Создать новое дело"),
            content: TextField(
              controller: myController,
              decoration: const InputDecoration(
                label: Text("Новое дело:"),
              ),
            ),
            actions: [
              TextButton(
                child: const Text("Отмена"),
                onPressed: () {
                  myController.clear();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text("Создать!"),
                onPressed: () {
                  setState(() {
                    if (myController.text.isNotEmpty && myController.text.trim() != "") {
                      _todoList.add(ToDoItem(
                          text: myController.text,
                          deleteCallback: this.deleteCallback));
                    }
                      myController.clear();
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}