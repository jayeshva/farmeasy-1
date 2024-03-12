import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyLoginpage extends StatefulWidget {
  const MyLoginpage({super.key});

  @override
  State<MyLoginpage> createState() => _LoginState();
}

class _LoginState extends State<MyLoginpage> {
  static const double textFieldWidth = 250; // Desired width for TextField
  static const double textFieldHeight = 50; // Desired height for TextField

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: const Color.fromARGB(89, 238, 238, 238),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                15, 50, 15, 15), // Adjust padding as needed
            child: Column(
              children: [
                Image.asset(
                  'images/agri.png',
                  width: 110,
                  height: 110,
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0x00d9d9d9).withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset:
                            const Offset(0, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 25, 15, 35),
                    child: Column(
                      children: [
                        Text(
                          "Login",
                          style: GoogleFonts.bentham(
                            textStyle: const TextStyle(
                              fontSize: 29,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: Column(
                            children: [
                              SizedBox(
                                height: textFieldHeight,
                                child: TextField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                        255, 242, 242, 243),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(226, 0, 137, 48)),
                                    ),
                                    border: OutlineInputBorder(),
                                    labelText: 'Email',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              SizedBox(
                                height: textFieldHeight,
                                child: TextField(
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                        255, 242, 242, 243),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(226, 0, 137, 48)),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(226, 0, 137, 48),
                                      ),
                                    ),
                                    labelText: 'Password',
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              SizedBox(
                                width: 100, // Set your desired width
                                height: 40, // Set your desired height
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/dashboard');
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(226, 0, 137, 48),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    "Sign in",
                                    style: GoogleFonts.bentham(
                                      textStyle: const TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              Text.rich(
                                TextSpan(
                                  text: "Are you new here? ",
                                  style: GoogleFonts.bentham(
                                    textStyle: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.red,
                                    ),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "Sign up",
                                      style: GoogleFonts.bentham(
                                        textStyle: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.green,
                                        ),
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushNamed(
                                              context, '/signup');
                                          // Handle sign-up button tap here
                                        },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
