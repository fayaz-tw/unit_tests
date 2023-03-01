import 'package:flutter/material.dart';
import 'package:unit_tests/TodoItem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<TodoItem> todos = [];

  void onFloatingActionButtonClicked() {
    addTodoItem();
  }

  void addTodoItem() {}

  void onTodoItemChecked(bool isChecked, int id) {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
      floatingActionButton: buildFloatingActionButton(),
    );
  }

  Widget buildTodoItem(
      bool isComplete, String title, Function(bool) onCheckChanged) {
    return Row(
      children: [Checkbox(value: isComplete, onChanged: (e) {}), Text(title)],
    );
  }

  Widget buildBody() {
    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: 10,
      itemBuilder: (c, i) => buildTodoItem(false, "Hello", (bool checked) {}),
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
