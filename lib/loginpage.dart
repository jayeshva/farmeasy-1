import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyLoginpage extends StatefulWidget {
  const MyLoginpage({super.key});

  @override
  State<MyLoginpage> createState() => _LoginState();
}

class _LoginState extends State<MyLoginpage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
        body: Container(
      color: const Color.fromARGB(89, 238, 238, 238),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
            15, 70, 15, 15), // Adjust padding as needed
        child: Column(
          children: [
            Image.asset(
              'images/agri.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 40),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0x00d9d9d9).withOpacity(0.4),
                    spreadRadius: 2,
                    blurRadius: 1,
                    offset: const Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
              width: double.infinity,
              height: 500,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 25, 15, 15),
                child: Column(
                  children: [
                    Text("Login",
                        style: GoogleFonts.bentham(
                          textStyle: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                      child: Column(children: [
                        const TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 242, 242, 243),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(226, 0, 137,
                                      48)), // Border color when focused
                            ),
                            border: OutlineInputBorder(),
                            labelText: 'Email',
                          ),
                        ),
                        const SizedBox(height: 50),
                        const TextField(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Color.fromARGB(255, 242, 242, 243),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(226, 0, 137,
                                      48)), // Border color when focused
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color.fromARGB(226, 0, 137,
                                    48), // Set the border color here
                              ),
                            ),
                            labelText: 'Password',
                          ),
                        ),
                        const SizedBox(height: 50),
                        SizedBox(
                          width: 180, // Set your desired width
                          height: 50, // Set your desired height
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
                            child: Text("Sign in",
                                style: GoogleFonts.bentham(
                                  textStyle: const TextStyle(
                                    fontSize: 22,
                                  ),
                                )),
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
                                    color:
                                        Colors.green, // Change color to green
                                  ),
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(context, '/signup');
                                    // Handle sign-up button tap here
                                  },
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    )));
  }
}
