class TodoItem {
  final int id;
  final String title;
  final String description;
  final int dueOn;
  bool completed;

  TodoItem(this.title, this.description, this.dueOn, this.completed, this.id);
}
