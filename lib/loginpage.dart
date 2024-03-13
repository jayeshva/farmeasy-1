import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);

  @override
  State<MyLoginPage> createState() => _LoginState();
}

class _LoginState extends State<MyLoginPage> {
  static const double textFieldHeight = 50;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
              padding: const EdgeInsets.fromLTRB(15, 50, 15, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
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
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 25, 15, 35),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                                    controller: _emailController,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor:
                                          Color.fromARGB(255, 242, 242, 243),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(226, 0, 137, 48),
                                        ),
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
                                    controller: _passwordController,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor:
                                          Color.fromARGB(255, 242, 242, 243),
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
                                      labelText: 'Password',
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                SizedBox(
                                  width: 100,
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _login();
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
                                            Navigator.pushNamed(context, '/signup');
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

  void _login() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isNotEmpty && _isValidEmail(email) && password.isNotEmpty) {
      Navigator.pushNamed(context, '/dashboard');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Invalid Data'),
            content: const Text('Please enter a valid email and password.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  bool _isValidEmail(String email) {
    String emailPattern =
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regex = RegExp(emailPattern);
    return regex.hasMatch(email);
  }
}
