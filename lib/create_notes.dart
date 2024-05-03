import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreateNotes extends StatefulWidget {
  const CreateNotes({super.key});

  @override
  State<CreateNotes> createState() => _CreateNotesState();
}

class _CreateNotesState extends State<CreateNotes> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
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
                    IconButton(
                      onPressed: () {},
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextField(
                      controller: titleController,
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
                      controller: descriptionController,
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
