import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MySchemes extends StatefulWidget {
  const MySchemes({super.key});

  @override
  State<MySchemes> createState() => _MySchemesState();
}

class _MySchemesState extends State<MySchemes> {
  var schemeData = [
    {
      'scheme_name': 'Scheme 1',
      'scheme_category': 'Category A',
      'scheme_last_date': '01-01-2022',
      'created_at': '01-01-2022',
      'scheme_description': 'Description of scheme 1...',
    },
    {
      'scheme_name': 'Scheme 2',
      'scheme_category': 'Category B',
      'scheme_last_date': '01-01-2022',
      'created_at': '01-01-2022',
      'scheme_description': 'Description of scheme 2...',
    },
    {
      'scheme_name': 'Scheme 3',
      'scheme_category': 'Category A',
      'last_date': '01-01-2022',
      'created_at': '01-01-2022',
      'scheme_description': 'Description of scheme 3...',
    }
  ];
  @override
  void initState() {
    super.initState();
    fetchSchemeData();
  }

  Future<void> fetchSchemeData() async {
    try {
      final response = await http
          .get(Uri.parse('https://localhost:8000/schemes/fetchScheme'));
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        setState(() {
          schemeData = responseData
              .map((scheme) => scheme as Map<String, dynamic>)
              .toList();
        });
        print(responseData['data']);
        schemeData = responseData['data'];
        print(schemeData);
        setState(() {
          schemeData = responseData.map((scheme) => scheme as Map<String, String>).toList();
        });
      } else {
        throw Exception('Failed to fetch scheme data');
      }
    } catch (error) {
      print('Error fetching scheme data: $error');
      // Handle error as needed
    }
  }

  List<String> filterData = [
    'All',
    'Category A',
    'Category B',
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
        body: Column(
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
                child: ListView.builder(
                  itemCount: schemeData.length,
                  itemBuilder: (context, index) {
                    final data = schemeData[index];
                    if (_selectedFilter == 'All' ||
                        data['scheme_category'] == _selectedFilter) {
                      return SchemaWidget(
                        schemaName: data['scheme_name'],
                        category: data['scheme_category'],
                        lastDate: data['last_date'],
                        updatedOn: data['created_at'],
                        description: data['scheme_description'],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
            ),
          ],
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
              padding: const EdgeInsets.fromLTRB(2, 0, 0, 5),
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
