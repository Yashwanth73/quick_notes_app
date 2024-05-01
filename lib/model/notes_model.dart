class Note {
  late int id;
  late String title;
  late String content;
  late bool isImportant;
  late bool isCompleted;
  Note({required this.id, required this.title, required this.content});
  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'content': content};
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(id: map['id'], title: map['title'], content: map['content']);
  }
}
