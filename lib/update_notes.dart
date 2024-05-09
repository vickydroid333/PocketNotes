import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/note_model.dart';
import 'package:notes/notes_provider.dart';
import 'package:provider/provider.dart';

class UpdateNotes extends StatefulWidget {
  final Note note;
  final int index;
  const UpdateNotes({super.key, required this.note, required this.index});

  @override
  State<UpdateNotes> createState() => _UpdateNotesState();
}

class _UpdateNotesState extends State<UpdateNotes> {
  final _textController = TextEditingController();
  final _contentController = TextEditingController();
  List<Note> allNotes = [];

  void _updateNote(NotesProvider provider) {
    final newTitle = _textController.text;
    final newText = _contentController.text;

    widget.note.title = newTitle;
    widget.note.content = newText;

    final noteIndex = widget.index;
    if (noteIndex != -1) {
      final newNote = Note(widget.note.id, newTitle, newText);
      provider.updateNote(widget.index, newNote);

      Navigator.popUntil(
          context, (route) => route.isFirst); // Close the page after update
    }
  }

  @override
  void initState() {
    _textController.text = widget.note.title;
    _contentController.text = widget.note.content;
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context);
    return MaterialApp(
      theme: ThemeData(colorScheme: const ColorScheme.dark()),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          padding:
              const EdgeInsets.only(left: 26, top: 55, right: 24, bottom: 55),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Image.asset('assets/Vector.png'),
                    style: IconButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: const Color.fromRGBO(59, 59, 59, 100)),
                  ),
                  IconButton(
                    onPressed: () => _updateNote(notesProvider),
                    icon: Image.asset('assets/save.png'),
                    style: IconButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: const Color.fromRGBO(59, 59, 59, 100)),
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          filled: true,
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none, // Remove all borders
                          ),
                          hintText: 'Title',
                          hintStyle: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 48,
                            ),
                          ),
                        ),
                        style: const TextStyle(fontSize: 35.0),
                        maxLines: null, // Allow multiline input
                      ),
                      const SizedBox(height: 12.0),
                      const Divider(
                        height: 0.1,
                        color: Colors.grey,
                      ),
                      const SizedBox(height: 12.0),
                      TextField(
                        controller: _contentController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderSide: BorderSide.none, // Remove all borders
                          ),
                          hintText: 'Type something...',
                          hintStyle: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 23,
                            ),
                          ),
                        ),
                        style: const TextStyle(fontSize: 23.0),
                        maxLines: null, // Allow multiline input
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
