import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MySchemes extends StatefulWidget {
  const MySchemes({super.key});

  @override
  State<MySchemes> createState() => _MySchemesState();
}

class _MySchemesState extends State<MySchemes> {
  var schemeData = [
      {
      'schemaName': 'Scheme 1',
      'category': 'Category A',
      'lastDate': '12/03/2024',
      'updatedOn': '12/03/2024',
      'description': 'This is a description of Scheme 1'
    },
    {
      'schemaName': 'Scheme 2',
      'category': 'Category B',
      'lastDate': '13/03/2024',
      'updatedOn': '13/03/2024',
      'description': 'This is a description of Scheme 2'
    },
    {
      'schemaName': 'Scheme 3',
      'category': 'Category A',
      'lastDate': '14/03/2024',
      'updatedOn': '14/03/2024',
      'description': 'This is a description of Scheme 3'
    },
    {
      'schemaName': 'Scheme 4',
      'category': 'Category B',
      'lastDate': '15/03/2024',
      'updatedOn': '15/03/2024',
      'description': 'This is a description of Scheme 4'
    },
    {
      'schemaName': 'Scheme 5',
      'category': 'Category A',
      'lastDate': '16/03/2024',
      'updatedOn': '16/03/2024',
      'description': 'This is a description of Scheme 5'
    },
    {
      'schemaName': 'Scheme 6',
      'category': 'Category B',
      'lastDate': '17/03/2024',
      'updatedOn': '17/03/2024',
      'description': 'This is a description of Scheme 6'
    },
    {
      'schemaName': 'Scheme 7',
      'category': 'Category A',
      'lastDate': '18/03/2024',
      'updatedOn': '18/03/2024',
      'description': 'This is a description of Scheme 7'
    },
    {
      'schemaName': 'Scheme 8',
      'category': 'Category B',
      'lastDate': '19/03/2024',
      'updatedOn': '19/03/2024',
      'description': 'This is a description of Scheme 8'
    },
    {
      'schemaName': 'Scheme 9',
      'category': 'Category A',
      'lastDate': '20/03/2024',
      'updatedOn': '20/03/2024',
      'description': 'This is a description of Scheme 9'
    },
    {
      'schemaName': 'Scheme 10',
      'category': 'Category B',
      'lastDate': '21/03/2024',
      'updatedOn': '21/03/2024',
      'description': 'This is a description of Scheme 10'
    }
  ];

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
              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          backgroundColor: const Color(0x0000892f).withOpacity(1),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children:
               [
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
                    if (_selectedFilter == 'All' || data['category'] == _selectedFilter) {
                      return SchemaWidget(
                        schemaName: data['schemaName'],
                        category: data['category'],
                        lastDate: data['lastDate'],
                        updatedOn: data['updatedOn'],
                        description: data['description'],
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
        padding: const EdgeInsets.fromLTRB(8,8,8,10),
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
               const SizedBox(height: 1,),
              Text("Category      : $category"),
              const SizedBox(height: 1,),
              Text("Last date      : $lastDate"),
               const SizedBox(height: 1,),
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
