import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

String rootUrl = "https://code.jayworks.tech:8000";

class MyRegistrationPage extends StatefulWidget {
  const MyRegistrationPage({Key? key}) : super(key: key);

  @override
  State<MyRegistrationPage> createState() => _RegistrationState();
}

class _RegistrationState extends State<MyRegistrationPage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _genderController;
  late TextEditingController _passwordController;

  late String aadhaarFilePath;
  late String panFilePath;
  late String photoFilePath;

  late TextEditingController _otpController;
  final double textFieldHeight = 47;
  static const double sizedBoxHeight = 15;

  // State variables to track whether files are uploaded
  bool isAadhaarUploaded = false;
  bool isPanUploaded = false;
  bool isPhotoUploaded = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();
    _genderController = TextEditingController();
    _passwordController = TextEditingController();
    _otpController = TextEditingController();
    aadhaarFilePath = '';
    panFilePath = '';
    photoFilePath = '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _genderController.dispose();
    _passwordController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> registerUser(
      {required String name,
      required String email,
      required String phone,
      required String gender,
      required String password,
      required String aadhaarFilePath,
      required String panFilePath,
      required String photoFilePath}) async {
    // API endpoint for registration
    String url = '$rootUrl/register/v2';

    try {
      // Create multipart request
      var request = http.MultipartRequest('POST', Uri.parse(url));

      // Add fields to the request
      request.fields['user_name'] = name;
      request.fields['user_email'] = email;
      request.fields['user_password'] = password;
      request.fields['user_mobile'] = phone;
      request.fields['user_gender'] = gender;

      // Add files to the request
      if (isAadhaarUploaded) {
        request.files.add(await http.MultipartFile.fromPath(
          'user_aadhaar',
          aadhaarFilePath,
        ));
      }
      if (isPanUploaded) {
        request.files.add(await http.MultipartFile.fromPath(
          'user_pan',
          panFilePath,
        ));
      }
      if (isPhotoUploaded) {
        request.files.add(await http.MultipartFile.fromPath(
          'user_photo',
          photoFilePath,
        ));
      }

      // Send the request
      var response = await request.send();
      var responseData = await response.stream.bytesToString();
      var jsonData = json.decode(responseData);
      print(jsonData);

      // Check the status code of the response
      if (response.statusCode == 200) {
        // Registration successful
        _showOTPDialog();
      } else {
        // Registration failed
        _showErrorDialog(jsonData['message']);
        print('Failed to register user: ${jsonData['message']}');
      }
    } catch (error) {
      // Handle any errors that occurred during the process
      _showErrorDialog('Failed to register user');
      print('Error registering user: $error');
    }
  }

  Future<http.Response> verifyOTP(String otp) async {
    // Define your API endpoint for OTP verification
    String url = '$rootUrl/verify/$otp';

    try {
      // Send a POST request to verify OTP
      final response = await http.get(
        Uri.parse(url), // Pass the OTP in the request body
      );
      return response;
    } catch (error) {
      // Handle any errors that occurred during the process
      print('Error verifying OTP: $error');
      throw error;
    }
  }

  void _showOTPDialog() {
    bool isButtonEnabled = false;

    showDialog(
      barrierDismissible: false,
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
                      ? () async {
                          String otp = _otpController.text;
                          // Verify OTP
                          var response = await verifyOTP(otp);
                          if (response.statusCode == 200) {
                            Fluttertoast.showToast(
                              msg: "OTP verified successfully!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                            );
                            // Navigate to sign-in page
                            Navigator.pushNamed(context, '/signin');
                          } else {
                            Fluttertoast.showToast(
                              msg: "Kindly check your OTP!",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              timeInSecForIosWeb: 4,
                            );
                          }
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

  void _showErrorDialog(String errorMessage) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _uploadAadhaar() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        aadhaarFilePath = file.path;
        isAadhaarUploaded = true;
      });
    }
  }

  Future<void> _uploadPan() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        panFilePath = file.path;
        isPanUploaded = true;
      });
    }
  }

  Future<void> _uploadPhoto() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      setState(() {
        photoFilePath = file.path;
        isPhotoUploaded = true;
      });
    }
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
              padding: const EdgeInsets.fromLTRB(15, 60, 15, 15),
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
                                  child: TextField(
                                    controller: _nameController,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor:
                                          Color.fromARGB(255, 242, 242, 243),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(226, 0, 137, 48),
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
                                  child: TextField(
                                    controller: _emailController,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor:
                                          Color.fromARGB(255, 242, 242, 243),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(226, 0, 137, 48),
                                        ),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(226, 0, 137, 48),
                                        ),
                                      ),
                                      labelText: 'Email',
                                    ),
                                  ),
                                ),
                                const SizedBox(height: sizedBoxHeight),
                                SizedBox(
                                  height: textFieldHeight,
                                  child: TextField(
                                    controller: _phoneController,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor:
                                          Color.fromARGB(255, 242, 242, 243),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(226, 0, 137, 48),
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
                                  child: TextField(
                                    controller: _genderController,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor:
                                          Color.fromARGB(255, 242, 242, 243),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(226, 0, 137, 48),
                                        ),
                                      ),
                                      border: OutlineInputBorder(),
                                      labelText: 'Gender',
                                    ),
                                  ),
                                ),
                                const SizedBox(height: sizedBoxHeight),
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
                                          color:
                                              Color.fromARGB(226, 0, 137, 48),
                                        ),
                                      ),
                                      border: OutlineInputBorder(),
                                      labelText: 'Password',
                                    ),
                                  ),
                                ),
                                const SizedBox(height: sizedBoxHeight),
                                // Inside the build method of _RegistrationState class
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: isAadhaarUploaded
                                          ? null
                                          : _uploadAadhaar,
                                      style: ElevatedButton.styleFrom(
                                        primary: isAadhaarUploaded
                                            ? Colors.grey
                                            : Colors.blue,
                                      ),
                                      child: Text(
                                        'Upload Aadhaar',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    ElevatedButton(
                                      onPressed:
                                          isPanUploaded ? null : _uploadPan,
                                      style: ElevatedButton.styleFrom(
                                        primary: isPanUploaded
                                            ? Colors.grey
                                            : Colors.blue,
                                      ),
                                      child: Text(
                                        'Upload PAN',
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5),
                                ElevatedButton(
                                  onPressed:
                                      isPhotoUploaded ? null : _uploadPhoto,
                                  style: ElevatedButton.styleFrom(
                                    primary: isPhotoUploaded
                                        ? Colors.grey
                                        : Colors.blue,
                                  ),
                                  child: const Text(
                                    'Upload Photo',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: 110,
                                  height: 40,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      registerUser(
                                        name: _nameController.text,
                                        email: _emailController.text,
                                        phone: _phoneController.text,
                                        gender: _genderController.text,
                                        password: _passwordController.text,
                                        aadhaarFilePath: aadhaarFilePath,
                                        panFilePath: panFilePath,
                                        photoFilePath: photoFilePath,
                                      );
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
}
