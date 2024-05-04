import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/create_notes.dart';
import 'package:notes/note_model.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class NotesProvider extends ChangeNotifier {
  List<Note> notes = [];

  void addNote(Note note) {
    const uniqueId = Uuid();
    final generateUniqueId = uniqueId.v4();
    note.id = generateUniqueId;
    notes.add(note);
    notifyListeners(); // Notify UI of changes
  }

  void deleteNote(Note note) {
    notes.remove(note);
    notifyListeners();
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final createNote = CreateNote();
  final List<Color> colors = [
    const Color.fromRGBO(255, 158, 158, 100),
    const Color.fromRGBO(255, 245, 153, 100),
    const Color.fromRGBO(158, 255, 255, 100),
    const Color.fromRGBO(182, 156, 255, 100),
    Colors.blueGrey,
    Colors.greenAccent
  ];
  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context);
    return MaterialApp(
        theme: ThemeData(colorScheme: const ColorScheme.highContrastDark()),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromRGBO(37, 37, 37, 100),
            shape: const CircleBorder(),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CreateNotes(
                            createNote: createNote,
                          )));
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          body: ListView.builder(
            itemCount: notesProvider.notes.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: Key(notesProvider.notes[index].id),
                background: Container(
                  color: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  if (direction == DismissDirection.endToStart) {
                    // Delete the note
                    Provider.of<NotesProvider>(context, listen: false)
                        .deleteNote(notesProvider.notes[index]);
                  }
                },
                child: Card(
                  color: colors[index % colors.length],
                  margin:
                      const EdgeInsets.only(left: 24.0, right: 24.0, top: 16.0),
                  child: ListTile(
                    title: Text(
                      textAlign: TextAlign.center,
                      notesProvider.notes[index].title,
                      style: GoogleFonts.nunito(
                          textStyle: const TextStyle(
                              fontSize: 25, color: Colors.black)),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }
}
