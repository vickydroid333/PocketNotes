class Note {
  final String id;
  final String title;
  final String content;

  Note(this.id, this.title, this.content);

  factory Note.fromJson(Map<String, dynamic> json) => Note(
        json['id'] as String,
        json['title'] as String,
        json['content'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'content': content,
      };
}
