import 'package:flutter/material.dart';
import 'package:my_todo_list/models/todo.dart';
import 'package:my_todo_list/todo_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final List<Todo> todos = [
    const Todo(
      title: 'Buy egg',
      description: 'There is no egg in the kitchen',
      priority: Priority.low
    ),
    const Todo(
      title: 'Finish the project',
      description: 'THe project must be submitted this week',
      priority: Priority.urget
    ),
    const Todo(
      title: 'Pay bills',
      description: 'The gas bill needs paying ASAP',
      priority: Priority.high
    ),
    const Todo(
      title: 'Learn Flutter',
      description: 'Try to make an apps',
      priority: Priority.medium
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        centerTitle: true,
        backgroundColor: Colors.grey[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(child: TodoList(todos: todos)),
          ],
        ),
      ),
    );
  }
}