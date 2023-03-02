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

  void onReturn(dynamic value) {
    setState(() {});
  }

  void onFloatingActionButtonClicked() {
    if (mounted) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (c) => AddTodoScreen()))
          .then(onReturn);
    }
  }

  void addTodoItem() {}

  void onTodoItemChecked(bool isChecked, int id) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  Widget buildTodoItem(TodoItem item, Function(bool, int) onCheckChanged) {
    return Row(
      children: [
        Checkbox(
          value: item.completed,
          onChanged: (e) => onCheckChanged(e ?? false, item.id),
        ),
        Text(item.title)
      ],
    );
  }

  Widget buildBody() {
    final dbHelper = DatabaseHelper(dbInstance);

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: dbHelper.recordsCount(),
      itemBuilder: (c, i) => buildTodoItem(
        dbHelper.recordAt(i)!,
        onTodoItemChecked,
      ),
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
