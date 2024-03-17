import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';


String url = 'https://code.jayworks.tech:8000';

class MySchemes extends StatefulWidget {
  const MySchemes({super.key});

  @override
  State<MySchemes> createState() => _MySchemesState();
}
class _MySchemesState extends State<MySchemes> {
  List<dynamic>? schemeData; // Initialize schemeData as a list
  @override
  void initState() {
    super.initState();
    fetchSchemeData();
  }

  List<String> filterData=['All']; // Initialize filterData with 'All' as the first item;

  String _selectedFilter = 'All';

  Future<void> fetchSchemeData() async {
    try {
      final response =
          await http.get(Uri.parse('$url/schemes/getScheme'));
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        var schemes = responseData['data'];
        // Extract unique categories
        Set<String> uniqueCategories = Set();
        schemes.forEach((scheme) {
          uniqueCategories.add(scheme['scheme_category']);
        });

        // Convert set to list for dropdown items
       filterData = ['All', ...uniqueCategories.toList()];
        schemes.forEach((scheme) {
          var lastDate = scheme['last_date'] != null
              ? DateTime.parse(scheme['last_date'])
              : null; // Convert 'last_date' string to DateTime or null if it's null
          var createdAt = DateTime.parse(scheme['created_at']);
          scheme['slast_date'] = lastDate != null
              ? DateFormat('dd-MM-yyyy').format(lastDate)
              : 'N/A'; // Format 'last_date' or provide a default value if it's null
          scheme['screated_at'] = DateFormat('dd-MM-yyyy').format(createdAt);
        });

        setState(() {
          schemeData = schemes;
        });

      } else {
        throw Exception('Failed to fetch scheme data');
      }
    } catch (error) {
      print('Error fetching scheme data: $error');
      // Handle error as needed
    }
  }

  Future<void> _refreshData() async {
    // Call fetchSchemeData to refresh data
    await fetchSchemeData();
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
            "Schemes",
            style: GoogleFonts.assistant(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          backgroundColor: const Color(0x0000892f).withOpacity(1),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 20, 10),
                    child: MyFilterDropdown(
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
                  ),
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: schemeData == null
                      ? const Center(child: CircularProgressIndicator())
                      : schemeData!.isEmpty
                          ? const Center(child: Text('No schemes available'))
                          : ListView.builder(
                              itemCount: schemeData!.length,
                              itemBuilder: (context, index) {
                                final data = schemeData![index];
                                // Filter schemes based on selected category
                                if (_selectedFilter == 'All' ||
                                    data['scheme_category'] ==
                                        _selectedFilter) {
                                  return SchemaWidget(
                                    // Pass scheme data to SchemaWidget
                                    schemaName: data['scheme_name'],
                                    category: data['scheme_category'],
                                    lastDate: data['slast_date'],
                                    updatedOn: data['screated_at'],
                                    description: data['scheme_description'],
                                  );
                                } else {
                                  return Container(); // Return empty container if scheme does not match selected category
                                }
                              },
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

class SchemaWidget extends StatelessWidget {
  final String? schemaName;
  final String? category;
  final String? lastDate;
  final String? updatedOn;
  final String? description;

  const SchemaWidget({
    required this.schemaName,
    required this.category,
    required this.lastDate,
    required this.updatedOn,
    required this.description,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 10),
        child: ListTile(
          title: Text(
            schemaName!,
            style: GoogleFonts.alata(
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 1,
              ),
              Text("Category      : $category"),
              const SizedBox(
                height: 1,
              ),
              Text("Last date      : $lastDate"),
              const SizedBox(
                height: 1,
              ),
              Text("Updated on  : $updatedOn"),
            ],
          ),
          trailing: ElevatedButton(
            onPressed: () {
              _showApplyPopup(context, description!);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(226, 0, 137, 48),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(2, 7, 0, 10),
              child: Text(
                "Apply",
                style: GoogleFonts.alata(
                  textStyle: const TextStyle(fontSize: 15),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showApplyPopup(BuildContext context, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Description"),
          content: Text(description),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle applying for the scheme
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
              ),
              child: const Text("Confirm Apply"),
            ),
          ],
        );
      },
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
