import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  createNote() {}
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(colorScheme: const ColorScheme.dark()),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.black45,
            elevation: 10,
            shape: const CircleBorder(side: BorderSide(strokeAlign: 1)),
            onPressed: () {
              // Your code to handle button press
            },
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
          body: Container(
            padding: const EdgeInsets.only(left: 24, top: 47),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
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
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.search),
                      style: IconButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: Colors.black45),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
