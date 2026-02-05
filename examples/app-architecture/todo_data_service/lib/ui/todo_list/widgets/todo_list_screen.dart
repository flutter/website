import 'package:flutter/material.dart';
import '../viewmodel/todo_list_viewmodel.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key, required this.viewModel});

  final TodoListViewModel viewModel;

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    widget.viewModel.add.addListener(_onAdd);
  }

  @override
  void dispose() {
    _controller.dispose();
    widget.viewModel.add.removeListener(_onAdd);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          // #docregion ListenableBuilder
          child: ListenableBuilder(
            listenable: widget.viewModel,
            builder: (context, child) {
              return ListView.builder(
                itemCount: widget.viewModel.todos.length,
                itemBuilder: (context, index) {
                  final todo = widget.viewModel.todos[index];
                  return ListTile(
                    title: Text(todo.task),
                    // #docregion Delete
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => widget.viewModel.delete.execute(todo.id),
                    ),
                    // #enddocregion Delete
                  );
                },
              );
            },
          ),
          // #enddocregion ListenableBuilder
        ),
        Material(
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Add a new task',
                    ),
                  ),
                ),
                // #docregion FilledButton
                FilledButton.icon(
                  onPressed: () =>
                      widget.viewModel.add.execute(_controller.text),
                  label: const Text('Add'),
                  icon: const Icon(Icons.add),
                ),
                // #enddocregion FilledButton
              ],
            ),
          ),
        ),
      ],
    );
  }

  // #docregion Add
  void _onAdd() {
    // Clear the text field when the add command completes.
    if (widget.viewModel.add.completed) {
      widget.viewModel.add.clearResult();
      _controller.clear();
    }
  }

  // #enddocregion Add
}
