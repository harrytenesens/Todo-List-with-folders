import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_again/button_blueprints_methods/first_screen_methods.dart';
import 'package:todolist_again/database/folder_db.dart';
import 'package:todolist_again/database/todoitem_db.dart';
import 'package:todolist_again/objectbox.g.dart';
import 'package:todolist_again/todo_blueprints/todo_model.dart';

class TodolistHomescreen extends StatefulWidget {
  const TodolistHomescreen({
    super.key,
    required this.folder,
  });
  final Folderdata folder;

  @override
  State<TodolistHomescreen> createState() => _TodolistHomescreenState();
}

class _TodolistHomescreenState extends State<TodolistHomescreen> {
  final _controller = TextEditingController();
  late Box<TodoItem> todoItembox;

  @override
  void initState() {
    super.initState();
    todoItembox =
        Provider.of<FirstScreen>(context, listen: false).store.box<TodoItem>();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  //adding todo lists
  void _addTodo(String text) {
    setState(() {
      // connecting the new task to the folder
      // todo.folder is the ToOne<Folderdata> relationship property in TodoItem
      final todo = TodoItem(text: text); todo.folder.target = widget.folder;
      todoItembox.put(todo);
    });
  }

  //deleting todo task
  void _deletetodo(TodoItem todo) {
    setState(() {
      todoItembox.remove(todo.id);
    });
  }

  // toggling checkbox
  void _toggleTodo(TodoItem todo) {
    setState(() {
      todo.isComplete = !todo.isComplete;
      todoItembox.put(todo);
    });
  }

  @override
  Widget build(BuildContext context) {
    final query =
        todoItembox.query(TodoItem_.folder.equals(widget.folder.id)).build();
    final todos = query.find();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(26),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Text(
                  'Your ${widget.folder.text} lists',
                  style: const TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 15),
              Expanded(
                child: ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) => TodoElement(
                          todoText: todos[index].text,
                          value: todos[index].isComplete,
                          onChanged: (value) => _toggleTodo(todos[index]),
                          onDelete: () => _deletetodo(todos[index]),
                        )),
              )
            ],
          ),
        ),
        // todo task add button
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Enter the task name'),
                content: TextField(controller: _controller),
                actions: [
                  TextButton(
                      onPressed: () {
                        _addTodo(_controller.text);
                        _controller.clear();
                        Navigator.pop(context);
                      },
                      child: const Text('Add'))
                ],
              ),
              // clears the controller when showdialog gets dismissed
            ).then((_) {
              _controller.clear();
            });
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
