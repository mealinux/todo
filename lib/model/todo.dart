class TODO {
  final int id;
  final String title;
  final String description;

  TODO({this.id, this.title, this.description});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  @override
  String toString() {
    return '{id: $id, title: $title, description: $description}';
  }
}
