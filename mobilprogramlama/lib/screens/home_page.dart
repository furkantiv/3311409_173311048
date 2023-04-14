import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobilprogramlama/screens/fav_notes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/note.dart';
import 'about.dart';
import 'note_screen.dart';
import 'settings_screen.dart'; // varsayılan olarak varsayılan not sınıfını içe aktarır

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Note> _notes = []; // notların listesi için boş bir liste tanımla
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _loadNotes(); // notları cihazdan yükle
  }

  // notları yerel depolama alanından yükle
  void _loadNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> noteStrings = prefs.getStringList('notes') ?? [];
    setState(() {
      _notes = noteStrings.map((note) => Note.fromJSON(note)).toList();
    });
  }

  // notlar listesini yerel depolama alanına kaydet
  void _saveNotes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> noteStrings = _notes.map((note) => note.toJSON()).toList();
    await prefs.setStringList('notes', noteStrings);
  }

  // yeni not eklemek için çağrılır
  void _addNote() async {
    // yeni bir not oluştur
    Note newNote = Note(dateTime: DateTime.now());
    // not ekranına gidin ve yeni notu ekleyin
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteScreen(note: newNote),
      ),
    );
    setState(() {
      _notes.add(newNote);
    });
    _saveNotes(); // notları kaydet
  }

  // mevcut bir notu düzenlemek için çağrılır
  void _editNote(int index) async {
    // seçilen notu düzenleyin
    Note selectedNote = _notes[index];
    // not ekranına gidin ve düzenlemek için seçilen notu geçirin
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteScreen(note: selectedNote),
      ),
    );
    setState(() {
      _notes[index] = selectedNote;
    });
    _saveNotes(); // notları kaydet
  }

  // bir notu silmek için çağrılır
  void _deleteNote(int index) async {
    setState(() {
      _notes.removeAt(index);
    });
    _saveNotes(); // notları kaydet
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Not Defteri'),
        actions: [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: Text('Ayarlar'),
                  value: 'settings',
                ),
                PopupMenuItem(
                  child: Text('Hakkında'),
                  value: 'about',
                ),
                PopupMenuItem(
                  child: Text('Favori Notlar'),
                  value: 'favs',
                ),
              ];
            },
            onSelected: (String value) {
              if (value == 'settings') {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => SettingsScreen()));
              } else if (value == 'about') {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => AboutScreen()));
              } else if (value == 'favs') {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => FavoritesScreen(notes: _notes)));
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.notes),
            title: Text(_notes[index].title),
            subtitle: Row(
              children: [
                Text(_notes[index].content),
                Spacer(),
                Text(DateFormat.yMd().format(_notes[index].dateTime)),
              ],
            ),
            onTap: () => _editNote(index),
            //onLongPress: () => _deleteNote(index),
            onLongPress: () {
              setState(() {
                _notes[index].favs = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Not favorilere eklendi!"),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _addNote,
      ),
    );
  }
}
