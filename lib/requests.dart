import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyRequests extends StatefulWidget {
  const MyRequests({super.key});

  @override
  State<MyRequests> createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  var requestData = [
    {
      'schemaName': 'Scheme 1',
      'tracker_id': '1234567890',
      'subsidy_id': '0987654321',
      'applied_on': '13/03/2024',
      'status': "Rejected",
      'comments': "Try again"
    },
    {
      'schemaName': 'Scheme 2',
      'tracker_id': '1234567890',
      'subsidy_id': '0987654321',
      'applied_on': '13/03/2024',
      'status': "Approved",
      'comments': "successfully Approved"
    },
    {
      'schemaName': 'Scheme 3',
      'tracker_id': '1234567890',
      'subsidy_id': '0987654321',
      'applied_on': '13/03/2024',
      'status': "Under Review",
      'comments': "Wait a week"
    },
    {
      'schemaName': 'Scheme 1',
      'tracker_id': '1234567890',
      'subsidy_id': '0987654321',
      'applied_on': '13/03/2024',
      'status': "Rejected",
      'comments': "Try again"
    },
    {
      'schemaName': 'Scheme 2',
      'tracker_id': '1234567890',
      'subsidy_id': '0987654321',
      'applied_on': '13/03/2024',
      'status': "Approved",
      'comments': "successfully Approved"
    },
    {
      'schemaName': 'Scheme 3',
      'tracker_id': '1234567890',
      'subsidy_id': '0987654321',
      'applied_on': '13/03/2024',
      'status': "Under Review",
      'comments': "Wait a week"
    },
  ];
  List<String> filterData = ['All', 'Approved', 'Rejected', 'Under Review'];

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
            "My Requests",
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
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final data = requestData[index];
                      // Check if the schema matches the selected filter
                      if (_selectedFilter == 'All' ||
                          data['status'] == _selectedFilter) {
                        return RequestWidget(
                          schemaName: data['schemaName'],
                          tracker_id: data['tracker_id'],
                          subsidy_id: data['subsidy_id'],
                          review_status: data['status'],
                          review_comments: data['comments'],
                          applied_on: data['applied_on'],
                        );
                      } else {
                        return Container(); // Return an empty container for schemas that don't match the filter
                      }
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemCount: requestData.length,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class RequestWidget extends StatelessWidget {
  final String? schemaName;
  final String? tracker_id;
  final String? subsidy_id;
  final String? review_status;
  final String? review_comments;
  final String? applied_on;

  const RequestWidget({
    required this.schemaName,
    required this.tracker_id,
    required this.subsidy_id,
    required this.review_status,
    required this.applied_on,
    required this.review_comments,
    super.key,
  });

  Color getColorForStatus(String? status) {
    switch (status) {
      case 'Approved':
        return Colors.green; // Set color to green for 'Approved' status
      case 'Rejected':
        return Colors.red; // Set color to red for 'Rejected' status
      case 'Under Review':
        return Colors.orange; // Set color to orange for 'Under Review' status
      default:
        return Colors.black; // Set default color
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      child: Container(
        width: 350,
        height: 105,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: const Color.fromARGB(190, 255, 255, 255).withOpacity(0.5),
              spreadRadius: 8,
              blurRadius: 30, // Increase blur radius for more pronounced shadow
              offset: const Offset(0, 3), // Offset for the shadow
            ),
          ],
          border: Border.all(
            color: const Color.fromARGB(255, 200, 195, 195), // Stroke color
            width: 2, // Stroke width
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        schemaName!,
                        style: GoogleFonts.alata(
                          textStyle: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        "Tracker id      : $tracker_id",
                        style: GoogleFonts.alata(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(height: 1.5),
                      Text(
                        "Subsidy id      : $subsidy_id",
                        style: GoogleFonts.alata(
                          textStyle: const TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 156, 156, 155),
                          ),
                        ),
                      ),
                      const SizedBox(height: 1.5),
                      Text(
                        "Applied on : $applied_on",
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
              SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15), // Add top padding here
                        child: Row(
                          children: [
                            Text(
                              "Status : ",
                              style: GoogleFonts.alata(
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Text(
                              review_status!,
                              style: GoogleFonts.alata(
                                textStyle: TextStyle(
                                  color: getColorForStatus(review_status),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Comments : ",
                            style: GoogleFonts.alata(
                              textStyle: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Text(
                            review_comments!,
                            style: GoogleFonts.alata(
                              textStyle: const TextStyle(
                                color: Color.fromARGB(255, 156, 156, 155),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
        width: 200,
        height: 45,
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
