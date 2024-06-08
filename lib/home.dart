import 'package:flutter/material.dart';
import 'package:my_todo_list/models/todo.dart';
import 'package:my_todo_list/todo_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final _formGlobalKey = GlobalKey<FormState>();

  Priority _selectedPriority = Priority.low;
  String _title = '';
  String _description = '';

  final List<Todo> todos = [
    const Todo(
      title: 'Buy egg',
      description: 'There is no egg in the kitchen',
      priority: Priority.low
    ),
    // const Todo(
    //   title: 'Finish the project',
    //   description: 'THe project must be submitted this week',
    //   priority: Priority.urget
    // ),
    // const Todo(
    //   title: 'Pay bills',
    //   description: 'The gas bill needs paying ASAP',
    //   priority: Priority.high
    // ),
    // const Todo(
    //   title: 'Learn Flutter',
    //   description: 'Try to make an apps',
    //   priority: Priority.medium
    // ),
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

            Form(
              key: _formGlobalKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  // todo title
                  TextFormField(
                    maxLength: 20,
                    decoration: const InputDecoration(
                      label: Text('Todo title')
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty){
                        return 'You must enter a value for the title!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _title = value!;
                    },
                  ),

                  // todo description
                  TextFormField(
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text('Todo description')
                    ),
                    validator: (v) {
                      if (v == null || v.isEmpty || v.length < 5){
                        return 'Enter a description at least 5 characters long!';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _description = value!;
                    },
                  ),

                  // todo priority
                  DropdownButtonFormField(
                    value: _selectedPriority,
                    decoration: const InputDecoration(
                      label: Text('Priority of todo')
                    ),
                    items: Priority.values.map((p) {
                      return DropdownMenuItem(
                        value: p,
                        child: Text(p.title),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedPriority = value!;
                      });
                    },
                  ),

                  // add button
                  const SizedBox(height: 20),
                  FilledButton(
                    onPressed: () {
                      if (_formGlobalKey.currentState!.validate()){
                        _formGlobalKey.currentState!.save();
                      }

                      setState(() {
                        todos.add(Todo(
                          title: _title,
                          description: _description,
                          priority: _selectedPriority));
                      });

                      _formGlobalKey.currentState!.reset();
                      _selectedPriority = Priority.low;
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.grey[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text('Add'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}