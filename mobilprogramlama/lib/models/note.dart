import 'dart:convert';

class Note {
  String title;
  String content;
  DateTime dateTime;
  bool favs;

  Note({
    this.title = '',
    this.content = '',
    required this.dateTime,
    this.favs = false,
  });

  // notu JSON formatına dönüştürür
  String toJSON() {
    return '{ "title": "$title", "content": "$content", "dateTime": "$dateTime", "favs": "$favs" }';
  }

  // JSON verilerinden notu oluşturur
  factory Note.fromJSON(String json) {
    Map<String, dynamic> data = jsonDecode(json);
    return Note(
      title: data['title'],
      content: data['content'],
      dateTime: data['dateTime'],
      favs: data['favs'],
    );
  }
}
