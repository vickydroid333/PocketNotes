import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/note_model.dart';
import 'package:notes/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CreateNotes extends StatefulWidget {
  const CreateNotes({super.key});

  @override
  State<CreateNotes> createState() => _CreateNotesState();
}

class _CreateNotesState extends State<CreateNotes> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _addNote() {
    const uniqueId = Uuid();
    final generateUniqueId = uniqueId.v4();
    final note = Note(
        // Generate unique id (e.g., using uuid package),
        generateUniqueId,
        _titleController.text,
        _contentController.text);
    Provider.of<NotesProvider>(context, listen: false).addNote(note);
    // Save notes to SharedPreferences
    Provider.of<NotesProvider>(context, listen: false).saveNotes();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
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
                    onPressed: _addNote,
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
                        controller: _titleController,
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
