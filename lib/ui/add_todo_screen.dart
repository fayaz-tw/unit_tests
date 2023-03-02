import 'package:flutter/material.dart';
import 'package:unit_tests/data/db_helper.dart';
import 'package:unit_tests/services/db.dart';
import 'package:unit_tests/utils/validators/todo.dart';

class AddTodoScreen extends StatelessWidget {
  AddTodoScreen({Key? key}) : super(key: key);

  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final DatabaseHelper dbHelper = DatabaseHelper(dbInstance);
  final TodoValidator validator = TodoValidator();

  bool validateForm(String title, String description) {
    return validator.isValidTitle(title) &&
        validator.isValidDescription(description);
  }

  void onAddButtonClicked(BuildContext context) {
    if (!validateForm(titleController.text, descriptionController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Title and Description must be valid"),
        ),
      );
      return;
    }

    dbHelper.add(titleController.text, descriptionController.text,
        DateTime.now().add(const Duration(days: 1)).millisecondsSinceEpoch);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Todo"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: buildBody(context),
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextField(
          controller: titleController,
          decoration: const InputDecoration(labelText: "Title"),
        ),
        TextField(
          controller: descriptionController,
          decoration: const InputDecoration(labelText: "Description"),
        ),
        ElevatedButton(
          onPressed: () => onAddButtonClicked(context),
          child: const Text("Add"),
        )
      ],
    );
  }
}
