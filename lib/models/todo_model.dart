class Todo {
  final int? id;
  final String title;
  final String? description;
  String? datestamp;
  final bool status;

  Todo({
    this.id,
    required this.title,
    this.description,
    this.datestamp,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'timestamp': datestamp,
      'status': status ? 1 : 0,
    };
  }
  // this to check if the variables were supplied
  @override
  String toString() {
    return 'Todo = $id, $title, $description, $datestamp, $status';
  }

}