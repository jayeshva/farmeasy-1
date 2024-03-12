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
                    height: 20,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Welcome !",
                      style: GoogleFonts.dancingScript(
                          textStyle: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold))),
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
                  Text("Better Idea Better Farming",
                      style: GoogleFonts.dancingScript(
                          textStyle: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold))),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(children: [
                    InkWell(
                      onTap: () => {Navigator.pushNamed(context, '/schemes')},
                      child: Image.asset("images/schemes.png",
                          width: 73, height: 73),
                    ),
                    Text(
                      "Schemes",
                      style: GoogleFonts.crimsonText(
                          textStyle: const TextStyle(fontSize: 22)),
                    )
                  ]),
                  Column(children: [
                    InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/requests');
                        },
                        child: Image.asset("images/tracker.png",
                            width: 73, height: 73)),
                    Text("Your requests",
                        style: GoogleFonts.crimsonText(
                            textStyle: const TextStyle(fontSize: 22)))
                  ])
                ],
              ),
              const SizedBox(
                height: 20,
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
                        width: 48,
                        height: 53,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: Text("Contact us",
                            style: GoogleFonts.crimsonText(
                                textStyle: const TextStyle(fontSize: 22))))
                  ]),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 14, 25),
                    child: Column(children: [
                      InkWell(
                        onTap: () => {Navigator.pushNamed(context, '/feeds')},
                        child: Image.asset("images/feed.png",
                            width: 70, height: 75),
                      ),
                      Text("Feeds",
                          style: GoogleFonts.crimsonText(
                              textStyle: const TextStyle(fontSize: 22)))
                    ]),
                  )
                ],
              ),
              const SizedBox(height: 20),
              Container(
                  child: Image.asset("images/dbg.png", height: 80, width: 250))
            ]),
          )
        ]),
      ),
    );
  }
}
