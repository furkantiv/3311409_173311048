import 'package:flutter/material.dart';
import '../models/note.dart'; // varsayılan olarak varsayılan not sınıfını içe aktarır

class NoteScreen extends StatefulWidget {
  final Note note;

  NoteScreen({required this.note});

  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notu Düzenle'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Başlık',
              ),
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                hintText: 'İçerik',
              ),
              maxLines: null,
            ),
            Spacer(),
            ElevatedButton(
              child: Text('Kaydet'),
              onPressed: () {
                widget.note.title = _titleController.text;
                widget.note.content = _contentController.text;
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
