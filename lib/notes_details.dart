import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/notes_provider.dart';
import 'package:provider/provider.dart';

class NotesDetails extends StatefulWidget {
  const NotesDetails({super.key});

  @override
  State<NotesDetails> createState() => _NotesDetailsState();
}

class _NotesDetailsState extends State<NotesDetails> {
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
                    onPressed: () {},
                    icon: Image.asset('assets/mode.png'),
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
                    Text(
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
                    Text(notesProvider.selectedNote!.content,
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
