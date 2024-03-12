import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Myfeeds extends StatefulWidget {
  const Myfeeds({super.key});

  @override
  State<Myfeeds> createState() => _MyfeedsState();
}

class _MyfeedsState extends State<Myfeeds> {
  @override
 Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
           leading: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/dashboard");
                },
                icon: const Icon(Icons.arrow_back)
              ),
          title: Text(
            "Feeds",
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