import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';


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
      'location': 'Kovafghgfhgfghi',
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
      'location': 'Kovafghgfhgfghi',
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
      'location': 'Kovafghgfhgfghi',
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
    'Kovai'
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
        body: Column(
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
            const SizedBox(height: 20),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: schemeData.map((data) {
                      if (_selectedFilter == 'All' ||
                          data['location'] == _selectedFilter) {
                        return Column(
                          children: [
                            ContactWidget(
                              userName: data['userName'],
                              organisation: data['organisation'],
                              location: data['location'],
                              mobile: data['mobile'],
                              email: data['email'],
                              designation: data['designation'],
                              profileimg: data['profileimg'],
                            ),
                            const SizedBox(height: 10), // Add space between cards
                          ],
                        );
                      } else {
                        return Container();
                      }
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class ContactWidget extends StatelessWidget {
//   final String? userName;
//   final String? organisation;
//   final String? location;
//   final String? email;
//   final String? mobile;
//   final String? designation;
//   final String? profileimg;

//   const ContactWidget({
//     required this.userName,
//     required this.organisation,
//     required this.location,
//     required this.email,
//     required this.mobile,
//     required this.designation,
//     required this.profileimg,
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       elevation: 5,
//       child: Container(
       
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(5),
//           boxShadow: [
//             BoxShadow(
//               color: const Color.fromARGB(190, 255, 255, 255).withOpacity(0.5),
//               spreadRadius: 8,
//               blurRadius: 30,
//               offset: const Offset(0, 3),
//             ),
//           ],
//           border: Border.all(
//             color: const Color.fromARGB(255, 200, 195, 195),
//             width: 2,
//           ),
//         ),
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(10,0,0,5),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Expanded(
//                 flex: 1,
//                 child: CircleAvatar(
//                   backgroundImage: MemoryImage(
//                     base64Decode(profileimg!),
//                   ),
//                   radius: 30,
//                 ),
//               ),
//               Expanded(
//                 flex: 3,
//                 child: Padding(
//                   padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         userName!,
//                         style: GoogleFonts.alata(
//                           fontSize: 16,
//                         ),
//                       ),
//                       SizedBox(height: 2),
//                       Text(
//                         "Organisation: $organisation",
//                         style: GoogleFonts.alata(
//                           fontSize: 12,
//                           fontWeight: FontWeight.normal,
//                         ),
//                       ),
//                       SizedBox(height: 1.5),
//                       Text(
//                         "Location: $location",
//                         style: GoogleFonts.alata(
//                           fontSize: 12,
//                           color: Color.fromARGB(255, 156, 156, 155),
//                         ),
//                       ),
//                       SizedBox(height: 1.5),
//                       Text(
//                         "Designation: $designation",
//                         style: GoogleFonts.alata(
//                           fontSize: 12,
//                           color: Color.fromARGB(255, 156, 156, 155),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Expanded(
//                 flex: 1,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     IconButton(
//                       onPressed: () {
//                         // Call functionality
//                       },
//                       icon: Icon(Icons.phone),
//                       color: Colors.green,
//                     ),
//                     SizedBox(height: 10),
//                     IconButton(
//                       onPressed: () {
//                         // Email functionality
//                       },
//                       icon: Icon(Icons.email),
//                       color: Colors.green,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


class ContactWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: Container(
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
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: CircleAvatar(
                  backgroundImage: MemoryImage(
                    base64Decode(profileimg!),
                  ),
                  radius: 30,
                ),
              ),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        userName!,
                        style: GoogleFonts.alata(
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Organisation: $organisation",
                        style: GoogleFonts.alata(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 1.5),
                      Text(
                        "Location: $location",
                        style: GoogleFonts.alata(
                          fontSize: 12,
                          color: const Color.fromARGB(255, 156, 156, 155),
                        ),
                      ),
                      const SizedBox(height: 1.5),
                      Text(
                        "Designation: $designation",
                        style: GoogleFonts.alata(
                          fontSize: 12,
                          color: const Color.fromARGB(255, 156, 156, 155),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        launch("tel:$mobile");
                      },
                      child: const Icon(
                        Icons.phone,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        launch("mailto:$email");
                      },
                      child: const Icon(
                        Icons.email,
                        color: Colors.green,
                      ),
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


class MyFilterDropdown extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: Container(
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
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: DropdownButton<String>(
            value: selectedFilter,
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 30,
            elevation: 16,
            style: GoogleFonts.cairo(textStyle: const TextStyle(
              color: Colors.black,
              fontSize: 16
            )),
            onChanged: onChanged,
            items: filterData.map((String value) {
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
