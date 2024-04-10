import 'dart:convert';
import 'package:intl/intl_standalone.dart';
import 'package:farmeasy/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

String url = 'https://code.jayworks.tech:8000';

class MyRequests extends StatefulWidget {
  const MyRequests({Key? key}) : super(key: key);

  @override
  State<MyRequests> createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  List<dynamic>? requestData; // Initialize requestData as a list
  bool isLoading = true; // Track whether data is loading or not

  @override
  void initState() {
    super.initState();
    fetchSchemeData();
  }

  List<String> filterData = ['All', 'Approved', 'Rejected', 'Under Review'];

  Future<void> fetchSchemeData() async {
    try {
      var token = Provider.of<UserProvider>(context, listen: false).user.token;
      final response = await http.get(
        Uri.parse('$url/schemes/tracker'),
        headers: {
          'x-auth-token': token,
        },
      );
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        var schemes = responseData['data'];

        schemes.forEach((scheme) {
          var createdAt = DateTime.parse(scheme['created_at']);
          scheme['screated_at'] = DateFormat('dd-MM-yyyy').format(createdAt);
        });

        setState(() {
          requestData = schemes;
          isLoading = false; // Set loading to false after data is fetched
        });
      } else {
        throw Exception('Failed to fetch scheme data');
      }
    } catch (error) {
      print('Error fetching scheme data: $error');
      // Handle error as needed
    }
  }

  String _selectedFilter = 'All';

  Future<void> _refreshData() async {
    setState(() {
      isLoading = true;
    });
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
            "My Requests",
            style: GoogleFonts.assistant(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 21),
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
                child: RefreshIndicator(
                  onRefresh: _refreshData,
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        ) // Show loading indicator
                      : ListView.builder(
                          itemCount: requestData?.length,
                          itemBuilder: (context, index) {
                            final data = requestData?[index];
                            if (_selectedFilter == 'All' ||
                                data['status'] == _selectedFilter) {
                              return RequestWidget(
                                schemaName: data['scheme_name'],
                                subsidy_id: data['scheme_id'],
                                scheme_category: data['scheme_category'],
                                review_status: data['status'],
                                review_comments: data['comment'],
                                applied_on: data['screated_at'],
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
      ),
    );
  }
}

class RequestWidget extends StatelessWidget {
  final String? schemaName;
  final String? scheme_category;
  final String? subsidy_id;
  final String? review_status;
  final String? review_comments;
  final String? applied_on;

  const RequestWidget({
    required this.schemaName,
    required this.scheme_category,
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              schemaName!,
              style: GoogleFonts.alata(fontSize: 16),
            ),
            const SizedBox(height: 5),
            Text(
              "Scheme id      : $subsidy_id",
              style: GoogleFonts.alata(fontSize: 12),
            ),
            Text(
              "Scheme category     : $scheme_category",
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
            const SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                textStyle: TextStyle(color: Colors.black, fontSize: 16)),
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
