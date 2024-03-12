import 'package:farmeasy/contact.dart';
import 'package:farmeasy/feeds.dart';
import 'package:farmeasy/loginpage.dart';
import 'package:farmeasy/profile.dart';
import 'package:farmeasy/requests.dart';
import 'package:farmeasy/schemes.dart';
import 'package:flutter/material.dart';
import 'package:farmeasy/dashboard.dart';
import 'package:farmeasy/registerpage.dart';
import 'package:farmeasy/splashpage.dart';

void main() {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure that Flutter is initialized

  // Create a GlobalKey to access the root navigator's context
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Delayed navigation after 5 seconds
  Future.delayed(const Duration(seconds: 1), () {
    // Navigate to Sign in route after 5 seconds
    navigatorKey.currentState!.pushReplacementNamed('/signin');
  });

  runApp(MaterialApp(
    navigatorKey: navigatorKey, // Pass the navigatorKey to MaterialApp
    initialRoute: '/',
    routes: <String, WidgetBuilder>{
      '/': (BuildContext context) => const MySplash(),
      '/signin': (BuildContext context) => const MyLoginpage(),
      '/signup': (BuildContext context) => const MyRegistrationpage(),
      '/dashboard': (BuildContext context) => const MyDashboard(),
      '/schemes': (BuildContext context) => const MySchemes(),
      '/requests': (BuildContext context) => const MyRequests(),
      '/contact': (BuildContext context) => const MyContact(),
      '/feeds': (BuildContext context) => const MyFeeds(),
      '/profile': (BuildContext context) => const MyProfile(),
    },
  ));
}
