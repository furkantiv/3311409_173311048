import 'package:flutter/material.dart';
import 'package:mobilprogramlama/screens/note_screen.dart';

import '../models/note.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Note> notes;

  FavoritesScreen({required this.notes});

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late List<Note> _favoriteNotes;

  @override
  void initState() {
    super.initState();
    _favoriteNotes = widget.notes.where((note) => note.favs).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favori Notlar'),
      ),
      body: _favoriteNotes.isNotEmpty
          ? ListView.builder(
              itemCount: _favoriteNotes.length,
              itemBuilder: (context, index) {
                final note = _favoriteNotes[index];
                return ListTile(
                  title: Text(note.title),
                  subtitle: Text(note.dateTime.toString()),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NoteScreen(note: note),
                      ),
                    );
                  },
                );
              },
            )
          : Center(
              child: Text('Henüz favori notunuz yok.'),
            ),
    );
  }
}
