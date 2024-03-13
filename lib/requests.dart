import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyRequests extends StatefulWidget {
  const MyRequests({Key? key}) : super(key: key);

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
      'comments': "Trygdfhgjhghghjghjfghjghghfghgshdfsfdgsfgfdgdfg again"
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
    }
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
              textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
            ),
          ),
          backgroundColor: const Color(0x0000892f).withOpacity(1),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
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
                child: ListView.builder(
                  itemCount: requestData.length,
                  itemBuilder: (context, index) {
                    final data = requestData[index];
                    if (_selectedFilter == 'All' || data['status'] == _selectedFilter) {
                      return RequestWidget(
                        schemaName: data['schemaName'],
                        tracker_id: data['tracker_id'],
                        subsidy_id: data['subsidy_id'],
                        review_status: data['status'],
                        review_comments: data['comments'],
                        applied_on: data['applied_on'],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ),
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
    Key? key,
  }) : super(key: key);

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
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    schemaName!,
                    style: GoogleFonts.alata(fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Tracker id      : $tracker_id",
                    style: GoogleFonts.alata(fontSize: 12),
                  ),
                  Text(
                    "Subsidy id      : $subsidy_id",
                    style: GoogleFonts.alata(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    "Applied on      : $applied_on",
                    style: GoogleFonts.alata(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            const SizedBox(width: 20),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text( 
                        "Status : ",
                        style: GoogleFonts.alata(
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        review_status!,
                        style: GoogleFonts.alata(
                          color: getColorForStatus(review_status),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "Comments : ",
                    style: GoogleFonts.alata(
                      fontSize: 12,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    review_comments!,
                    style: GoogleFonts.alata(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
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
            style: GoogleFonts.cairo(textStyle: TextStyle(
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
