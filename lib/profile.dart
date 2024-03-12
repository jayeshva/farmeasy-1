import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({super.key});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
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
            "Profile",
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