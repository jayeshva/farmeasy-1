import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyRegistrationPage extends StatefulWidget {
  const MyRegistrationPage({Key? key}) : super(key: key);

  @override
  State<MyRegistrationPage> createState() => _RegistrationState();
}

class _RegistrationState extends State<MyRegistrationPage> {
  late TextEditingController _otpController;
  final double textFieldHeight = 47;
  static const double sizedBoxHeight = 15;

  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            color: const Color.fromARGB(89, 238, 238, 238),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 80, 15, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Register Here",
                    style: GoogleFonts.bentham(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0x00d9d9d9).withOpacity(0.4),
                          spreadRadius: 2,
                          blurRadius: 1,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: textFieldHeight,
                                  child: const TextField(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color.fromARGB(
                                          255, 242, 242, 243),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(226, 0, 137, 48),
                                        ),
                                      ),
                                      border: OutlineInputBorder(),
                                      labelText: 'Name',
                                    ),
                                  ),
                                ),
                                const SizedBox(height: sizedBoxHeight),
                                SizedBox(
                                  height: textFieldHeight,
                                  child: const TextField(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color.fromARGB(
                                          255, 242, 242, 243),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(226, 0, 137, 48),
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(226, 0, 137, 48),
                                        ),
                                      ),
                                      labelText: 'Email',
                                    ),
                                  ),
                                ),
                                const SizedBox(height: sizedBoxHeight),
                                SizedBox(
                                  height: textFieldHeight,
                                  child: const TextField(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color.fromARGB(
                                          255, 242, 242, 243),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(226, 0, 137, 48),
                                        ),
                                      ),
                                      border: OutlineInputBorder(),
                                      labelText: 'Phone',
                                    ),
                                  ),
                                ),
                                const SizedBox(height: sizedBoxHeight),
                                SizedBox(
                                  height: textFieldHeight,
                                  child: const TextField(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color.fromARGB(
                                          255, 242, 242, 243),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(226, 0, 137, 48),
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(226, 0, 137, 48),
                                        ),
                                      ),
                                      labelText: 'Gender',
                                    ),
                                  ),
                                ),
                                const SizedBox(height: sizedBoxHeight),
                                SizedBox(
                                  height: textFieldHeight,
                                  child: const TextField(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color.fromARGB(
                                          255, 242, 242, 243),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(226, 0, 137, 48),
                                        ),
                                      ),
                                      border: OutlineInputBorder(),
                                      labelText: 'Password',
                                    ),
                                  ),
                                ),
                                const SizedBox(height: sizedBoxHeight),
                                SizedBox(
                                  height: textFieldHeight,
                                  child: const TextField(
                                    decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Color.fromARGB(
                                          255, 242, 242, 243),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(226, 0, 137, 48),
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(226, 0, 137, 48),
                                        ),
                                      ),
                                      labelText: 'Aadhaar',
                                    ),
                                  ),
                                ),
                                const SizedBox(height: sizedBoxHeight),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 40,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Handle file upload button tap here
                                        },
                                        child: const Text(
                                          'Upload Aadhar',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      height: 40,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          // Handle file upload button tap here
                                        },
                                        child: const Text(
                                          'Upload PAN',
                                          style: TextStyle(fontSize: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: 110,
                                  height: 40,
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
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
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
                                            color: Colors.green,
                                          ),
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.pushNamed(
                                                context, '/signin');
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
                    style: TextStyle(
                        color: isButtonEnabled ? Colors.green : Colors.grey),
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
