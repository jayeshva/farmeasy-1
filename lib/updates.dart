import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyUpdates extends StatefulWidget {
  const MyUpdates({super.key});

  @override
  State<MyUpdates> createState() => _MyUpdatesState();
}

class _MyUpdatesState extends State<MyUpdates> {
  @override
   Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
           leading: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/profile");
                },
                icon: const Icon(Icons.arrow_back)
              ),
          title: Text(
            "Updates",
            style: GoogleFonts.assistant(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          backgroundColor: const Color(0x0000892f).withOpacity(1),
          centerTitle: true,
        )),
    );
  }
}