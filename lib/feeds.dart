import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class MyFeeds extends StatefulWidget {
  const MyFeeds({Key? key}) : super(key: key);

  @override
  State<MyFeeds> createState() => _MyFeedsState();
}

class _MyFeedsState extends State<MyFeeds> {
  List<Map<String, dynamic>> feeds = [];

  @override
  void initState() {
    super.initState();
    fetchFeeds();
  }

  Future<void> fetchFeeds() async {
    final response = await http.get(Uri.parse('https://picsum.photos/v2/list'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);
      setState(() {
        feeds = responseData
            .map((item) => {
                  'image': item['download_url'],
                  'description': 'Description of feed...',
                })
            .toList();
      });
    } else {
      throw Exception('Failed to load feeds');
    }
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
        body: feeds.isEmpty
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: Column(
                  children: [
                    for (var feed in feeds)
                      FeedCard(
                        image: feed['image'],
                        description: feed['description'],
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}

class FeedCard extends StatelessWidget {
  final String? image;
  final String? description;

  const FeedCard({Key? key, this.image, this.description}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            image!,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              description!,
              style: GoogleFonts.assistant(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
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
