
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyContact extends StatefulWidget {
  const MyContact({super.key});

  @override
  State<MyContact> createState() => _MyContactState();
}

class _MyContactState extends State<MyContact> {
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
            "Contacts",
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