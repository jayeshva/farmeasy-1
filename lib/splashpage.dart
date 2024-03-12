import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MySplash extends StatelessWidget {
  const MySplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("images/agri.png", width: 110, height: 110),
                const SizedBox(
                    height: 10), // Add spacing between the image and text
                Text(
                  "FarmEasy",
                  style: GoogleFonts.bentham(
                    textStyle: const TextStyle(
                      fontSize: 28,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
