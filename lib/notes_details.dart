import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/note_model.dart';
import 'package:notes/notes_provider.dart';
import 'package:provider/provider.dart';

class NotesDetails extends StatefulWidget {
  final Note note;
  final int index;
  const NotesDetails({
    super.key,
    required this.note,
    required this.index,
  });

  @override
  State<NotesDetails> createState() => _NotesDetailsState();
}

class _NotesDetailsState extends State<NotesDetails> {
  final _textController = TextEditingController();
  final _contentController = TextEditingController();
  List<Note> allNotes = [];
  bool isEditing = false;

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
          (context), (route) => route.isFirst); // Close the page after update
      setState(() {
        isEditing = false;
        // Consider showing a success message or updating UI
      });
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding:
            const EdgeInsets.only(left: 26, top: 55, right: 24, bottom: 55),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Row(
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
                    onPressed: () {
                      if (isEditing) {
                        _updateNote(notesProvider);
                      } else {
                        setState(() {
                          isEditing = true; // Enable editing
                        });
                      }
                    },
                    icon: isEditing
                        ? Image.asset('assets/save.png')
                        : Image.asset('assets/mode.png'),
                    style: IconButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        backgroundColor: const Color.fromRGBO(59, 59, 59, 100)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    isEditing
                        ? TextField(
                            controller: _textController,
                            decoration: InputDecoration(
                              filled: true,
                              border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide.none, // Remove all borders
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
                          )
                        : Text(
                            notesProvider.selectedNote!.title,
                            style: GoogleFonts.nunito(
                                textStyle: const TextStyle(
                                    fontSize: 35, color: Colors.white)),
                          ),
                    const SizedBox(height: 24),
                    const Divider(
                      height: 0.1,
                      color: Colors.grey,
                    ),
                    const SizedBox(height: 24),
                    isEditing
                        ? TextField(
                            controller: _contentController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderSide:
                                    BorderSide.none, // Remove all borders
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
                          )
                        : Text(notesProvider.selectedNote!.content,
                            style: GoogleFonts.nunito(
                                textStyle: const TextStyle(
                                    fontSize: 23, color: Colors.white))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
