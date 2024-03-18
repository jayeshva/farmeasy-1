import 'package:farmeasy/models/user.dart';
import 'package:farmeasy/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl_standalone.dart';
String url = "https://code.jayworks.tech:8000";

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  // Sample user data
  final Map<String, String> userData = {
    'Name': 'John Doe',
    'Email': 'john.doe@example.com',
    'Phone': '+1234567890',
    'Gender': 'Male',
    'Aadhaar': '1234 5678 9012',
    'PAN': 'ABCDE1234F',
  };

  // Sample counts of subsidies
  final Map<String, int> subsidyCounts = {
    'Applied': 10,
    'Approved': 5,
    'Rejected': 2,
    'Under Review': 3,
  };
  void _launchURL(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}


  @override
  Widget build(BuildContext context) {
    String name = userData['Name'] ?? '';
    String email = userData['Email'] ?? '';
    String phone = userData['Phone'] ?? '';
    String gender = userData['Gender'] ?? '';
    String aadhaar = userData['Aadhaar'] ?? '';
    String pan = userData['PAN'] ?? '';

    // Extract the first letter of the name for the profile image
    String profileInitial = name.isNotEmpty ? name[0].toUpperCase() : '';
    final user = Provider.of<UserProvider>(context).user;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, "/dashboard");
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(
            "Profile",
            style: GoogleFonts.assistant(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 21,
              ),
            ),
          ),
          backgroundColor: const Color(0x0000892f).withOpacity(1),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue,
                backgroundImage: NetworkImage('$url/${user.img}'),
              ),
              const SizedBox(height: 20),
              _buildProfileInfo('Name', user.name),
              _buildProfileInfo('Email',user.email),
              _buildProfileInfo('Phone', user.mobile),
              _buildProfileInfo('Gender', user.gender),
              Text("Subsidy Data",
                  style: GoogleFonts.assistant(
                      textStyle: const TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.bold))),
              _buildProfileInfo('Applied', pan),
              _buildProfileInfo('Approved', pan),
              _buildProfileInfo('Rejected', pan),
              _buildProfileInfo('Under Reveiew', pan),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // View uploaded PAN document
                  _launchURL(url +'/'+ user.pan!);
                },
                child: Text('View PAN Document'),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).appBarTheme.backgroundColor,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  // View uploaded Aadhaar document
                   _launchURL(url+'/' + user.pan!);
                },
                child: Text('View Aadhaar Document'),
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).appBarTheme.backgroundColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.assistant(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.assistant(
              textStyle: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubsidyCount(String label, int count) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.assistant(
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Text(
            count.toString(),
            style: GoogleFonts.assistant(
              textStyle: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
