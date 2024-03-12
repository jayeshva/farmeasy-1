import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:google_fonts/google_fonts.dart';

class MyRegistrationpage extends StatefulWidget {
  const MyRegistrationpage({Key? key}) : super(key: key);

  @override
  State<MyRegistrationpage> createState() => _RegistrationState();
}

class _RegistrationState extends State<MyRegistrationpage> {
  late TextEditingController _otpController;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          color: const Color.fromARGB(89, 238, 238, 238),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 30, 15, 15),
            child: Column(
              children: [
                Text(
                  "Register Here",
                  style: GoogleFonts.bentham(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xD9D9D9).withOpacity(0.4),
                        spreadRadius: 2,
                        blurRadius: 1,
                        offset: const Offset(0, 4), // changes position of shadow
                      ),
                    ],
                  ),
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                          child: Column(
                            children: [
                              const TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 242, 242, 243),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(226, 0, 137, 48),
                                    ), // Border color when focused
                                  ),
                                  border: OutlineInputBorder(),
                                  labelText: 'Name',
                                ),
                              ),
                              const SizedBox(height: 30),
                              const TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 242, 242, 243),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(226, 0, 137, 48),
                                    ), // Border color when focused
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(226, 0, 137, 48),
                                    ), // Set the border color here
                                  ),
                                  labelText: 'Email',
                                ),
                              ),
                              const SizedBox(height: 30),
                              const TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 242, 242, 243),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(226, 0, 137, 48),
                                    ), // Border color when focused
                                  ),
                                  border: OutlineInputBorder(),
                                  labelText: 'Phone',
                                ),
                              ),
                              const SizedBox(height: 30),
                              const TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 242, 242, 243),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(226, 0, 137, 48),
                                    ), // Border color when focused
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(226, 0, 137, 48),
                                    ), // Set the border color here
                                  ),
                                  labelText: 'Gender',
                                ),
                              ),
                              const SizedBox(height: 30),
                              const TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 242, 242, 243),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(226, 0, 137, 48),
                                    ), // Border color when focused
                                  ),
                                  border: OutlineInputBorder(),
                                  labelText: 'Password',
                                ),
                              ),
                              const SizedBox(height: 30),
                              const TextField(
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 242, 242, 243),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(226, 0, 137, 48),
                                    ), // Border color when focused
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(226, 0, 137, 48),
                                    ), // Set the border color here
                                  ),
                                  labelText: 'Aadhaar',
                                ),
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 150,
                                    height: 40,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Handle file upload button tap here
                                      },
                                      child: const Text(
                                        'Upload Aadhar',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  SizedBox(
                                    width: 150,
                                    height: 40,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Handle file upload button tap here
                                      },
                                      child: const Text(
                                        'Upload PAN',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              SizedBox(
                                width: 180, // Set your desired width
                                height: 50, // Set your desired height
                                child: ElevatedButton(
                                  onPressed: () {
                                    _showOTPDialog();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(226, 0, 137, 48),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    "Sign up",
                                    style: GoogleFonts.bentham(
                                      textStyle: const TextStyle(
                                        fontSize: 22,
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
                                  text: "Are you Already a user? ",
                                  style: GoogleFonts.bentham(
                                    textStyle: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.red,
                                    ),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: "Sign in",
                                      style: GoogleFonts.bentham(
                                        textStyle: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.green, // Change color to green
                                        ),
                                      ),
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () {
                                          Navigator.pushNamed(
                                              context, '/signin');
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

void _showOTPDialog() {
  bool isButtonEnabled = false;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: const Text("Enter OTP"),
            content: TextField(
              controller: _otpController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              onChanged: (value) {
                setState(() {
                  isButtonEnabled = value.length == 6;
                });
              },
              decoration: const InputDecoration(
                hintText: "Enter OTP",
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "Resend",
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  // Resend OTP functionality
                },
              ),
              TextButton(
                onPressed: isButtonEnabled
                    ? () {
                        String otp = _otpController.text;
                        // Handle OTP confirmation
                        _otpController.clear(); // Clear the OTP field
                        Navigator.of(context).pop(); // Close the dialog
                      }
                    : null,
                child: Text(
                  "Confirm",
                  style: TextStyle(color: isButtonEnabled ? Colors.green : Colors.grey),
                ),
              ),
            ],
          );
        },
      );
    },
  );
}


  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }
}
