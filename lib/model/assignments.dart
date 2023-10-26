class Assignments {
  int? id;
  String? title;
  String? description;
  String? deadline;

  Assignments({this.id, this.title, this.description, this.deadline});

  factory Assignments.fromJson(Map<String, dynamic> obj) {
    return Assignments(
      id: obj['id'],
      title: obj['title'],
      description: obj['description'],
      deadline: obj['deadline'],
    );
  }
}
