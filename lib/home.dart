import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notes/create_notes.dart';
import 'package:notes/notes_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isDismissed = false; // Flag for undo visibility
  var dismissedItem;
  int undoSeconds = 5;

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
    final notesProvider = Provider.of<NotesProvider>(context, listen: false);
    WidgetsBinding.instance.addObserver(notesProvider); // Detach observer
    notesProvider.loadNotes(); // Load notes from SharedPreferences
  }

  @override
  void dispose() {
    super.dispose();
    final notesProvider = Provider.of<NotesProvider>(context, listen: false);
    WidgetsBinding.instance.removeObserver(notesProvider); // Detach observer
  }

  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NotesProvider>(context);
    return MaterialApp(
        theme: ThemeData(colorScheme: const ColorScheme.highContrastDark()),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            padding: const EdgeInsets.only(left: 24, top: 47, right: 24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Notes',
                      style: GoogleFonts.nunito(
                        textStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 43,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                          style: IconButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor:
                                  const Color.fromRGBO(59, 59, 59, 100)),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset('assets/info_outline.png'),
                          style: IconButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor:
                                  const Color.fromRGBO(59, 59, 59, 100)),
                        ),
                      ],
                    )
                  ],
                ),
                Expanded(
                  child: Stack(
                    children: [
                      ListView.builder(
                        padding: const EdgeInsets.only(bottom: 10),
                        itemCount: notesProvider.notes.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(notesProvider.notes[index].id),
                            direction: DismissDirection.endToStart,
                            background: const Card(
                                color: Colors.red,
                                margin: EdgeInsets.only(top: 16),
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 35,
                                )),
                            onDismissed: (direction) {
                              // Delete the note
                              setState(() {
                                isDismissed = true;
                                dismissedItem = notesProvider.notes[index];
                                Provider.of<NotesProvider>(context,
                                        listen: false)
                                    .deleteNote(notesProvider.notes[index]);
                                undoSeconds = 5; // Reset undo timer
                                notesProvider.saveNotes();
                              });
                              // Future.delayed(const Duration(seconds: 5), () {
                              //   setState(() {
                              //     isDismissed = false;
                              //   });
                              // });
                              Future.delayed(const Duration(seconds: 1), () {
                                Timer.periodic(const Duration(seconds: 1),
                                    (timer) {
                                  if (mounted) {
                                    setState(() {
                                      if (undoSeconds > 0) {
                                        undoSeconds--;
                                      } else {
                                        isDismissed = false;
                                        timer.cancel();
                                      }
                                    });
                                  }
                                });
                              });
                            },
                            child: Card(
                              margin: const EdgeInsets.only(top: 16),
                              color: colors[index % colors.length],
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
                      Visibility(
                        visible: isDismissed,
                        child: Positioned(
                          bottom: 50.0, // Position at the bottom
                          left: 0.0, // Position at the left edge (full width)
                          right: 0.0, // Position at the right edge (full width)
                          height: 50,
                          child: Container(
                            color: Colors.green,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  notesProvider.notes.insert(
                                      notesProvider.notes.length,
                                      dismissedItem);
                                  isDismissed = false;
                                });
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.only(left: 16, right: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Undo',
                                        style: GoogleFonts.nunito(
                                            textStyle: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white))),
                                    Text(' ($undoSeconds)',
                                        style: GoogleFonts.nunito(
                                            textStyle: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white))),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: const Color.fromRGBO(37, 37, 37, 100),
            shape: const CircleBorder(),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CreateNotes()));
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ));
  }
}
