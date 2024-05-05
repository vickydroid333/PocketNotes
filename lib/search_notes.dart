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
      backgroundColor: const Color.fromRGBO(37, 37, 37, 100),
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        backgroundColor: const Color.fromRGBO(37, 37, 37, 100),
        title: TextField(
          style: const TextStyle(color: Colors.white),
          onChanged: (value) {
            setState(() {
              searchQuery = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Search notes',
            hintStyle: GoogleFonts.nunito(
              textStyle: const TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.notesProvider.notes
            .where((note) =>
                note.title.toLowerCase().contains(searchQuery.toLowerCase()) ||
                note.content.toLowerCase().contains(searchQuery.toLowerCase()))
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
          return Container(
            padding: const EdgeInsets.only(left: 24, top: 10, right: 24),
            child: Card(
              color: colors[index % colors.length],
              child: ListTile(
                title: Text(
                  textAlign: TextAlign.center,
                  note.title,
                  style: GoogleFonts.nunito(
                      textStyle:
                          const TextStyle(fontSize: 25, color: Colors.black)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
