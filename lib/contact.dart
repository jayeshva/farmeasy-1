import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

var url = "https://code.jayworks.tech:8000";

class MyContact extends StatefulWidget {
  const MyContact({super.key});

  @override
  State<MyContact> createState() => _MyContactState();
}

class _MyContactState extends State<MyContact> {
  List<dynamic> contactData = []; // Update data type to allow null values
  List<String> filterData = ['All']; // Initialize filter data with 'All'
  String _selectedFilter = 'All'; // Initialize selected filter
  bool isLoading = true; // Initialize isLoading to true

  @override
  void initState() {
    super.initState();
    // Fetch contact data and set filters
    fetchContactData();
  }

  Future<void> fetchContactData() async {
    try {
      final response = await http
          .get(Uri.parse('$url/contacts/getContacts'));
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        // Extract unique localities for filters
        Set<String> uniqueLocalities = {'All'};
        var finalData = responseData['data'];
        finalData.forEach((contact) {
          uniqueLocalities.add(contact['contact_locality']);
        });
        setState(() {
          contactData = finalData;
          filterData = uniqueLocalities.toList();
          isLoading = false; // Set isLoading to false when data is fetched
        });
      } else {
        throw Exception('Failed to fetch contact data');
      }
    } catch (error) {
      print('Error fetching contact data: $error');
      setState(() {
        isLoading = false; // Set isLoading to false in case of error
      });
    }
  }

  Future<void> _refreshData() async {
    // Call the fetchContactData function to refresh data
    await fetchContactData();
  }

  @override
  Widget build(BuildContext context) {
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
            "Contacts",
            style: GoogleFonts.assistant(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            ),
          ),
          backgroundColor: const Color(0x0000892f).withOpacity(1),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: _refreshData, // Call _refreshData function when pulled to refresh
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
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: isLoading
                        ? const Center(
                            child:
                                CircularProgressIndicator()) // Show loading indicator if isLoading is true
                        : Column(
                            children: contactData.map((data) {
                              if (_selectedFilter == 'All' ||
                                  data['contact_locality'] == _selectedFilter) {
                                return Column(
                                  children: [
                                    ContactWidget(
                                      userName: data['contact_name'] ??
                                          '', // Provide default value for null fields
                                      organisation: data[
                                              'contact_organisation'] ??
                                          '', // Provide default value for null fields
                                      location: data['contact_locality'] ??
                                          '', // Provide default value for null fields
                                      mobile: data['contact_mobile'] ??
                                          '', // Provide default value for null fields
                                      email: data['contact_email'] ??
                                          '', // Provide default value for null fields
                                      designation: data['contact_designation'] ??
                                          '', // Provide default value for null fields
                                      profileimg: data['contact_img'] ??
                                          '', // Provide default value for null fields
                                    ),
                                    const SizedBox(
                                        height: 10), // Add space between cards
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
      ),
    );
  }
}


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
                  backgroundImage: profileimg != null
                    ? NetworkImage(url+profileimg!) as ImageProvider<Object> // Cast profileimg to ImageProvider<Object>
                    : const AssetImage('images/agri.png'), // Placeholder image if profileimg is null
                  radius: 60,
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
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 1.5),
                      Text(
                        "Location: $location",
                        style: GoogleFonts.alata(
                          fontSize: 13,
                          color: const Color.fromARGB(255, 156, 156, 155),
                        ),
                      ),
                      const SizedBox(height: 1.5),
                      Text(
                        "Designation: $designation",
                        style: GoogleFonts.alata(
                          fontSize: 13,
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
                        size: 30,
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
                        size: 30,
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
            style: GoogleFonts.cairo(
                textStyle: const TextStyle(color: Colors.black, fontSize: 16)),
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
