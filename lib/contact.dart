import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';

String generateBase64Image() {
  // Sample image URL
  String imageUrl = 'https://via.placeholder.com/150/565656';

  // Convert image URL to bytes
  List<int> imageBytes = utf8.encode(imageUrl);

  // Encode bytes to base64
  String base64Image = base64Encode(imageBytes);

  return base64Image;
}

class MyContact extends StatefulWidget {
  const MyContact({super.key});

  @override
  State<MyContact> createState() => _MyContactState();
}

class _MyContactState extends State<MyContact> {
  var schemeData = [
    {
      'profileimg': generateBase64Image(),
      'userName': 'Jayesh V A',
      'organisation': 'TNAU',
      'mobile': '7602787005',
      'email': 'jayesh.cs20@bitsathy.ac.in',
      'location': 'Erode',
      'designation': 'officer'
    },
    {
      'profileimg': generateBase64Image(),
      'userName': 'Jayesh V A',
      'organisation': 'TNAU',
      'mobile': '7602787005',
      'email': 'jayesh.cs20@bitsathy.ac.in',
      'location': 'Kovai',
      'designation': 'clerk'
    },
    {
      'profileimg': generateBase64Image(),
      'userName': 'Jayesh V A',
      'organisation': 'TNAU',
      'mobile': '7602787005',
      'email': 'jayesh.cs20@bitsathy.ac.in',
      'location': 'Erode',
      'designation': 'clerk'
    },
    {
      'profileimg': generateBase64Image(),
      'userName': 'Jayesh V A',
      'organisation': 'TNAU',
      'mobile': '7602787005',
      'email': 'jayesh.cs20@bitsathy.ac.in',
      'location': 'Kovai',
      'designation': 'clerk'
    },
    {
      'profileimg': generateBase64Image(),
      'userName': 'Jayesh V A',
      'organisation': 'TNAU',
      'mobile': '7602787005',
      'email': 'jayesh.cs20@bitsathy.ac.in',
      'location': 'Erode',
      'designation': 'VAO'
    },
  ];

  List<String> filterData = [
    'All',
    'Erode',
    'Kovai',
  ];

  String _selectedFilter = 'All';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/dashboard");
              },
              icon: const Icon(Icons.arrow_back)),
          title: Text(
            "Contacts",
            style: GoogleFonts.assistant(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            ),
          ),
          backgroundColor: const Color(0x0000892f).withOpacity(1),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const Material(elevation: 5, child: SizedBox(height: 10)),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MyFilterDropdown(
                      filterData: filterData,
                      selectedFilter: _selectedFilter,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedFilter = newValue;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: schemeData.isNotEmpty
                    ? ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final data = schemeData[index];
                          // Check if the schema matches the selected filter
                          if (_selectedFilter == 'All' ||
                              data['location'] == _selectedFilter) {
                            return ContactWidget(
                                userName: data['userName'],
                                organisation: data['organisation'],
                                location: data['location'],
                                mobile: data['mobile'],
                                email: data['email'],
                                designation: data['designation'],
                                profileimg: data['profileimg']);
                          } else {
                            return Container(); // Return an empty container for schemas that don't match the filter
                          }
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),
                        itemCount: schemeData.length,
                      )
                    : Container(), // Render an empty container if there are no schemes matching the filter
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactWidget extends StatefulWidget {
  final String? userName;
  final String? organisation;
  final String? location;
  final String? email;
  final String? mobile;
  final String? designation;
  final String? profileimg;

  const ContactWidget({
    required this.userName,
    required this.organisation,
    required this.location,
    required this.email,
    required this.mobile,
    required this.designation,
    required this.profileimg,
    Key? key,
  }) : super(key: key);

  @override
  _ContactWidgetState createState() => _ContactWidgetState();
}

class _ContactWidgetState extends State<ContactWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: Container(
        height: 105,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(190, 255, 255, 255).withOpacity(0.5),
              spreadRadius: 8,
              blurRadius: 30,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(
            color: const Color.fromARGB(255, 200, 195, 195),
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 7),
                  child: CircleAvatar(
                    backgroundImage: MemoryImage(
                      base64Decode(widget.profileimg!),
                    ),
                    radius: 30,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 7, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.userName!,
                        style: GoogleFonts.alata(
                          textStyle: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Organisation      : ${widget.organisation}",
                        style: GoogleFonts.alata(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(height: 1.5),
                      Text(
                        "Location               : ${widget.location}",
                        style: GoogleFonts.alata(
                          textStyle: const TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 156, 156, 155),
                          ),
                        ),
                      ),
                      const SizedBox(height: 1.5),
                      Text(
                        "Designation        : ${widget.designation}",
                        style: GoogleFonts.alata(
                          textStyle: const TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 156, 156, 155),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        // Call functionality
                      },
                      icon: Icon(Icons.phone),
                      color: Colors.green,
                    ),
                    // const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {
                        // Email functionality
                      },
                      icon: Icon(Icons.email),
                      color: Colors.green,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyFilterDropdown extends StatefulWidget {
  final List<String> filterData;
  final String selectedFilter;
  final ValueChanged<String?>? onChanged;

  const MyFilterDropdown({
    required this.filterData,
    required this.selectedFilter,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  _MyFilterDropdownState createState() => _MyFilterDropdownState();
}

class _MyFilterDropdownState extends State<MyFilterDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Container(
        width: 150,
        height: 35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: const Color(0x00d9d9d9).withOpacity(0.5),
              spreadRadius: 2,
              offset: const Offset(4, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 5, 0, 0),
          child: DropdownButton<String>(
            value: widget.selectedFilter,
            icon: Image.asset(
              "images/filter.png",
              width: 27,
              height: 27,
            ),
            iconSize: 30,
            elevation: 16,
            style: GoogleFonts.cairo(
              textStyle: const TextStyle(fontSize: 16),
            ),
            onChanged: widget.onChanged,
            items: widget.filterData.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 9),
                  child: Text(value),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
