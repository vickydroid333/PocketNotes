import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/home.dart';
import 'package:notes/note_model.dart';
import 'package:provider/provider.dart';

class CreateNotes extends StatefulWidget {
  final CreateNote createNote;
  const CreateNotes({super.key, required this.createNote});

  @override
  State<CreateNotes> createState() => _CreateNotesState();
}

class _CreateNotesState extends State<CreateNotes> {
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
              Align(
                alignment: Alignment.topCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Image.asset('assets/Vector.png'),
                      style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor:
                              const Color.fromRGBO(59, 59, 59, 100)),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset('assets/visibility.png'),
                      style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor:
                              const Color.fromRGBO(59, 59, 59, 100)),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 5.0), // Add horizontal padding
                    ),
                    IconButton(
                      onPressed: () {
                        final note = widget.createNote.createNote();
                        Provider.of<NotesProvider>(context, listen: false)
                            .addNote(note);
                        widget.createNote
                            .clearFields(); // Clear fields after adding
                        Navigator.pop(context);
                      },
                      icon: Image.asset('assets/save.png'),
                      style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor:
                              const Color.fromRGBO(59, 59, 59, 100)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextField(
                        controller: widget.createNote.titleController,
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          hintText: 'Title',
                          hintStyle: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 48,
                            ),
                          ),
                        ),
                        maxLines: null, // Allow multiline input
                      ),
                      const SizedBox(height: 16.0),
                      TextField(
                        controller: widget.createNote.contentController,
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.blue)),
                          hintText: 'Type something...',
                          hintStyle: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              fontSize: 23,
                            ),
                          ),
                        ),
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

class CreateNote {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  Note createNote() {
    return Note(
      "",
      titleController.text,
      contentController.text,
    );
  }

  void clearFields() {
    titleController.clear();
    contentController.clear();
  }
}
