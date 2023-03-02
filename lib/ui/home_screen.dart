import 'package:flutter/material.dart';
import 'package:unit_tests/data/db.dart';
import 'package:unit_tests/data/db_helper.dart';
import 'package:unit_tests/model/TodoItem.dart';
import 'package:unit_tests/services/db.dart';
import 'package:unit_tests/ui/add_todo_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<TodoItem> todos = [];
  final dbHelper = DatabaseHelper(dbInstance);

  void onReturn(dynamic value) {
    setState(() {});
  }

  void onFloatingActionButtonClicked() {
    if (mounted) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (c) => AddTodoScreen()))
          .then(onReturn);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Something went wrong")));
    }
  }

  void onTodoItemChecked(bool isChecked, int id) {
    try {
      if (isChecked) {
        dbHelper.markCompleted(id);
      } else {
        dbHelper.markInComplete(id);
      }

      setState(() {});
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed to update item $e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  Widget buildTodoItemTitle(TodoItem item) {
    if (item.completed) {
      return Text(
        item.title,
        style: const TextStyle(decoration: TextDecoration.lineThrough),
      );
    } else {
      return Text(item.title);
    }
  }

  Widget buildTodoItem(TodoItem item) {
    return InkWell(
      onTap: () => onTodoItemChecked(!item.completed, item.id),
      child: Row(
        key: ValueKey("todo-item-${item.id}"),
        children: [
          Checkbox(
            value: item.completed,
            onChanged: (e) => onTodoItemChecked(!item.completed, item.id),
          ),
          buildTodoItemTitle(item)
        ],
      ),
    );
  }

  Widget buildBody() {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: dbHelper.recordsCount(),
      itemBuilder: (c, i) => buildTodoItem(dbHelper.recordAt(i)!),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: const Text("Home Screen"),
    );
  }

  Widget buildFloatingActionButton() {
    return FloatingActionButton(
      onPressed: onFloatingActionButtonClicked,
      child: const Icon(Icons.add),
    );
  }
}
