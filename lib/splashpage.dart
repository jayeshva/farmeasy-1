import 'dart:convert';
import 'dart:html';
import 'package:farmeasy/models/user.dart';
import 'package:farmeasy/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl_standalone.dart';
String url = "https://code.jayworks.tech:8000";

class MySplash extends StatefulWidget {
  const MySplash({Key? key}) : super(key: key);

  @override
  State<MySplash> createState() => _MySplashState();
}

class _MySplashState extends State<MySplash> {
  Future<void> getUserData() async {
    // Get user data from the server
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');
    if (token != null) {
      var verify = await http.post(Uri.parse('$url/tokenIsValid'), headers: {
        'x-auth-token': token,
      });

      if (verify.statusCode == 200) {
        var response = await http.get(Uri.parse('$url/user'), headers: {
          'x-auth-token': token,
        });
        if (response.statusCode == 200) {
          var responseData = json.decode(response.body);
          // print(responseData);
          userProvider.setUser(User.fromMap(responseData));
          Navigator.pushNamed(context, "/dashboard");
        }
      } else {
        // Navigator.pushNamed(context, "/signin");
      }
    } else {
      print("No token found");
      Navigator.pushNamed(context, "/signin");
    }
  }

  @override
  void initState() {
    super.initState();
    getUserData();
  }

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
