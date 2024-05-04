import "package:flutter/material.dart";


class ToDoItem extends StatefulWidget {
  const ToDoItem({super.key, required this.text, required this.deleteCallback});

  final String text;
  final Function deleteCallback;

  @override
  State<ToDoItem> createState() => _ToDoItemState(text, deleteCallback);
}

class _ToDoItemState extends State<ToDoItem> {
  _ToDoItemState(this._text, this._callback);

  String _text;
  bool _isDone = false;
  final Function _callback;

  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(
          bottom: 20,
          left: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(child: TextButton(
              onPressed: () => showDialog(
                context: context,
                builder: (BuildContext context) {
                  myController.text = _text;
                  return AlertDialog(
                    title: const Text("Редактирование"),
                    content: TextField(
                      controller: myController,
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
                        child: const Text("Сохранить"),
                        onPressed: () {
                          setState(() {
                            if (myController.text.isNotEmpty &&
                                myController.text.trim() != "") {
                              _text = myController.text;
                              myController.clear();
                            }
                          });
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              ),
              child: Text(
                _text,
                style: _isDone
                    ? const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        decoration: TextDecoration.lineThrough,
                        decorationThickness: 2.0,
                      )
                    : const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
              ),
            ),),
            Stack(
              children: [
                Checkbox(
                  value: _isDone,
                  activeColor: Colors.black,
                  onChanged: (value) {
                    setState(() {
                      if (value != null) {
                        _isDone = value;
                      }
                    });
                  },
                ),
                Container(
                  padding: const EdgeInsets.only(
                    left: 50,
                  ),
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _callback(widget);
                      });
                    },
                    icon: const Icon(
                      Icons.delete_outline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
