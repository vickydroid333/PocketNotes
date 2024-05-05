import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/notes_provider.dart';

class SearchNotes extends StatefulWidget {
  final NotesProvider notesProvider;
  final String searchQuery;
  const SearchNotes(
      {super.key, required this.notesProvider, required this.searchQuery});

  @override
  State<SearchNotes> createState() => _SearchNotesState();
}

class _SearchNotesState extends State<SearchNotes> {
  String searchQuery = '';
  final _textController = TextEditingController();
  final List<Color> colors = [
    const Color.fromRGBO(255, 158, 158, 100),
    const Color.fromRGBO(255, 245, 153, 100),
    const Color.fromRGBO(158, 255, 255, 100),
    const Color.fromRGBO(182, 156, 255, 100),
    Colors.blueGrey,
    Colors.greenAccent
  ];

  @override
  void initState() {
    super.initState();
    searchQuery = widget.searchQuery;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: const EdgeInsets.only(left: 24, top: 70, right: 24),
        child: Column(
          children: [
            TextField(
              readOnly: false,
              controller: _textController,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.circular(60.0),
                ),
                contentPadding: const EdgeInsets.only(
                  left: 20.0, // Set left margin
                  top: 15.0, // Set top margin
                  right: 5.0, // Set right margin
                  bottom: 8.0, // Set bottom margin
                ),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.clear_sharp,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    _textController.clear();
                  },
                ),
                filled: true, // Enable background fill (optional)
                fillColor: const Color.fromRGBO(
                    59, 59, 59, 100), // Optional for transparent background
                border: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Colors.transparent), // Transparent border
                  borderRadius:
                      BorderRadius.circular(60.0), // Set border radius
                ),
                hintText: 'Search notes',
                hintStyle: GoogleFonts.nunito(
                  textStyle: const TextStyle(fontSize: 20, color: Colors.grey),
                ),
              ),
              style: const TextStyle(color: Colors.white),
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.only(bottom: 5),
                itemCount: widget.notesProvider.notes
                    .where((note) =>
                        note.title
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()) ||
                        note.content
                            .toLowerCase()
                            .contains(searchQuery.toLowerCase()))
                    .toList()
                    .length,
                itemBuilder: (context, index) {
                  final note = widget.notesProvider.notes
                      .where((note) =>
                          note.title
                              .toLowerCase()
                              .contains(searchQuery.toLowerCase()) ||
                          note.content
                              .toLowerCase()
                              .contains(searchQuery.toLowerCase()))
                      .toList()[index];
                  return Card(
                    margin: const EdgeInsets.only(top: 16),
                    color: colors[index % colors.length],
                    child: ListTile(
                      title: Text(
                        textAlign: TextAlign.center,
                        note.title,
                        style: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
