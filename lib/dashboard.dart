import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDashboard extends StatelessWidget {
  const MyDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "FarmEasy",
            style: GoogleFonts.assistant(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
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
                            fontSize: 30, fontWeight: FontWeight.bold)),
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
                title: const Text(' Track Requsest'),
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
                title: const Text('LogOut'),
                onTap: () {
                  Navigator.pushNamed(context, '/signin');
                },
              ),
            ],
          ),
        ),
        body: Column(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Row(
                children: [
                  SizedBox(
                    height: 30,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Welcome !",
                      style: GoogleFonts.dancingScript(
                          textStyle: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold))),
                ],
              ),
              const Row(
                children: [
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Better Idea Better Farm",
                      style: GoogleFonts.dancingScript(
                          textStyle: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold))),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    InkWell(
                      onTap: () => {Navigator.pushNamed(context, '/schemes')},
                      child: Image.asset("images/schemes.png",
                          width: 93, height: 93),
                    ),
                    Text(
                      "Schemes",
                      style: GoogleFonts.crimsonText(
                          textStyle: const TextStyle(fontSize: 25)),
                    )
                  ]),
                  Column(children: [
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/requests');
                        },
                        child: Image.asset("images/tracker.png",
                            width: 90, height: 90)),
                    Text("Your requests",
                        style: GoogleFonts.crimsonText(
                            textStyle: const TextStyle(fontSize: 25)))
                  ])
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/contact');
                      },
                      child: Image.asset(
                        "images/contact.png",
                        width: 67,
                        height: 67,
                      ),
                    ),
                    Text("Contact Us",
                        style: GoogleFonts.crimsonText(
                            textStyle: const TextStyle(fontSize: 25)))
                  ]),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 0, 14, 25),
                    child: Column(children: [
                      InkWell(
                        onTap: () => {
                          Navigator.pushNamed(context, '/feeds')
                        },
                        child: Image.asset("images/feed.png",
                            width: 90, height: 90),
                      ),
                      Text("Feeds",
                          style: GoogleFonts.crimsonText(
                              textStyle: const TextStyle(fontSize: 25)))
                    ]),
                  )
                ],
              ),
              const SizedBox(height: 50),
              Container(
                  child: Image.asset("images/dbg.png", height: 200, width: 200))
            ]),
          )
        ]),
      ),
    );
  }
}
