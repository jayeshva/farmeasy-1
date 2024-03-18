import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl_standalone.dart';
class MyDashboard extends StatelessWidget {
  const MyDashboard({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "FarmEasy",
            style: GoogleFonts.assistant(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
            ),
          ),
          backgroundColor: const Color(0x0000892f).withOpacity(1),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              SizedBox(
                height: 70,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(80, 20, 0, 15),
                  child: Text(
                    "FarmEasy",
                    style: GoogleFonts.bentham(
                        textStyle: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text(' My Profile '),
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              ListTile(
                leading: const Icon(Icons.note_rounded),
                title: const Text(' Subsidy'),
                onTap: () {
                  Navigator.pushNamed(context, '/schemes');
                },
              ),
              ListTile(
                leading: const Icon(Icons.stream_rounded),
                title: const Text(' Feeds'),
                onTap: () {
                  Navigator.pushNamed(context, '/feeds');
                },
              ),
              ListTile(
                leading: const Icon(Icons.track_changes_rounded),
                title: const Text(' Track Request'),
                onTap: () {
                  Navigator.pushNamed(context, '/requests');
                },
              ),
              ListTile(
                leading: const Icon(Icons.contact_emergency),
                title: const Text(' Contact us'),
                onTap: () {
                  Navigator.pushNamed(context, '/contact');
                },
              ),
              ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('Log Out'),
                onTap: () {
                  _showLogoutConfirmationDialog(context);
                },
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Welcome !",
                      style: GoogleFonts.dancingScript(
                          textStyle: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Better Idea Better Farming",
                      style: GoogleFonts.dancingScript(
                          textStyle: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () =>
                                Navigator.pushNamed(context, '/schemes'),
                            child: Image.asset(
                              "images/schemes.png",
                              width: 73,
                              height: 73,
                            ),
                          ),
                          Text(
                            "Schemes",
                            style: GoogleFonts.crimsonText(
                                textStyle: const TextStyle(fontSize: 22)),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () =>
                                Navigator.pushNamed(context, '/requests'),
                            child: Image.asset(
                              "images/tracker.png",
                              width: 73,
                              height: 73,
                            ),
                          ),
                          Text(
                            "Your requests",
                            style: GoogleFonts.crimsonText(
                                textStyle: const TextStyle(fontSize: 22)),
                          )
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () =>
                                Navigator.pushNamed(context, '/contact'),
                            child: Image.asset(
                              "images/contact.png",
                              width: 48,
                              height: 53,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Text(
                              "Contact us",
                              style: GoogleFonts.crimsonText(
                                  textStyle: const TextStyle(fontSize: 22)),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 15, 14, 25),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () =>
                                  Navigator.pushNamed(context, '/feeds'),
                              child: Image.asset(
                                "images/feed.png",
                                width: 70,
                                height: 75,
                              ),
                            ),
                            Text(
                              "Feeds",
                              style: GoogleFonts.crimsonText(
                                  textStyle: const TextStyle(fontSize: 22)),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Container(
                    child:
                        Image.asset("images/dbg.png", height: 80, width: 250),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

void logout(BuildContext context) async {
  try {
    // Clear JWT token from shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('x-auth-token');
    
    // Navigate to login screen or any other appropriate screen
    Navigator.pushNamed(context, '/signin');
  } catch (error) {
    print('Error during logout: $error');
    // Handle error, if any
  }
}
  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Log Out"),
          content: Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                logout(context);
              },
              child: Text("Log Out"),
            ),
          ],
        );
      },
    );
  }
}
