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
                icon: const Icon(Icons.arrow_back)),
            title: Text(
              "Schemes",
              style: GoogleFonts.assistant(
                textStyle:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
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
      const SizedBox(height: 20),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
  shrinkWrap: true,
  itemBuilder: (context, index) {
    final data = schemeData[index];
    // Check if the schema matches the selected filter
    if (_selectedFilter == 'All' || data['category'] == _selectedFilter) {
      return SchemaWidget(
        schemaName: data['schemaName'],
        category: data['category'],
        lastDate: data['lastDate'],
        updatedOn: data['updatedOn'],
        description: data['description'],
      );
    } else {
      return Container(); // Return an empty container for schemas that don't match the filter
    }
  },
  separatorBuilder: (context, index) => const SizedBox(height: 10),
  itemCount: schemeData.length,
)

      )
    ],
  ),
),

     ) );
  }
}

class SchemaWidget extends StatefulWidget {
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
  _SchemaWidgetState createState() => _SchemaWidgetState();
}

class _SchemaWidgetState extends State<SchemaWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: Container(
        width: 380,
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
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.schemaName!,
                        style: GoogleFonts.alata(
                          textStyle: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Category      : ${widget.category}",
                        style: GoogleFonts.alata(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(height: 1.5),
                      Text(
                        "Last date      : ${widget.lastDate}",
                        style: GoogleFonts.alata(
                          textStyle: const TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 156, 156, 155),
                          ),
                        ),
                      ),
                      const SizedBox(height: 1.5),
                      Text(
                        "Updated on : ${widget.updatedOn}",
                        style: GoogleFonts.alata(
                          textStyle: const TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 156, 156, 155),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(
                  width: 85,
                  height: 42,
                  child: ElevatedButton(
                    onPressed: () {
                      _showApplyPopup(context, widget.description!);
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
                          textStyle: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
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
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle applying for the scheme
                Navigator.of(context).pop(); // Close the dialog
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
              textStyle: const TextStyle(fontSize: 18),
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