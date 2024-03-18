import 'dart:convert';
import 'package:farmeasy/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl_standalone.dart';
String url = "https://code.jayworks.tech:8000";

class MyFeeds extends StatefulWidget {
  const MyFeeds({Key? key}) : super(key: key);

  @override
  State<MyFeeds> createState() => _MyFeedsState();
}

class _MyFeedsState extends State<MyFeeds> {
  List<dynamic> feedData = [];

  @override
  void initState() {
    super.initState();
    fetchFeeds();
  }

  Future<void> fetchFeeds() async {
      var token = Provider.of<UserProvider>(context, listen: false).user.token;

    final response = await http.get(Uri.parse('$url/feeds/getFeeds'));
    if (response.statusCode == 200) {
      var responseData = jsonDecode(response.body);
      var finalData = responseData['data'];
      finalData.forEach((data) {
        var createdAt = DateTime.parse(data['created_at']);
        data['post_date'] = DateFormat('dd-MM-yyyy').format(createdAt);
      });

      setState(() {
        feedData = finalData;
      });
    } else {
      throw Exception('Failed to load feeds');
    }
  }

  Future<void> _refreshFeeds() async {
    await fetchFeeds();
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
            "Feeds",
            style: GoogleFonts.assistant(
              textStyle:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          backgroundColor: const Color(0x0000892f).withOpacity(1),
          centerTitle: true,
        ),
        body: RefreshIndicator(
          onRefresh: _refreshFeeds,
          child: feedData.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: feedData.map((data) {
                      return FeedCard(
                        // Check for null values before passing them to FeedCard
                        image: data['feed_img'] ?? '',
                        title: data['feed_name'] ?? '',
                        description: data['feed_description'] ?? '',
                        source_url: data['feed_source_url'] ?? '',
                        postDate: data['post_date'] ?? '',
                      );
                    }).toList(),
                  ),
                ),
        ),
      ),
    );
  }
}
 void _launchURL(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Could not launch $url';
  }
}
class FeedCard extends StatelessWidget {
  final String? image;
  final String? title;
  final String? description;
  final String? source_url;
  final String? postDate;

  const FeedCard(
      {Key? key,
      this.image,
      this.title,
      this.description,
      this.source_url,
      this.postDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            url + image!,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
            child: Text(
              "Posted at: " + postDate!,
              style: GoogleFonts.assistant(
                textStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
            child: Text(
              title!,
              style: GoogleFonts.assistant(
                  textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              description!,
              style: GoogleFonts.assistant(
                textStyle: const TextStyle(
                  fontSize: 14,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _launchURL(source_url!);
              // Handle "View More" button tap
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.green, // Change button color to green
            ),
            child: Text('View More'),
          ),
        ],
      ),
    );
  }
}
