import 'package:farmeasy/contact.dart';
import 'package:farmeasy/feeds.dart';
import 'package:farmeasy/loginpage.dart';
import 'package:farmeasy/profile.dart';
import 'package:farmeasy/providers/userProvider.dart';
import 'package:farmeasy/requests.dart';
import 'package:farmeasy/schemes.dart';
import 'package:flutter/material.dart';
import 'package:farmeasy/dashboard.dart';
import 'package:farmeasy/registerpage.dart';
import 'package:farmeasy/splashpage.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl_standalone.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  
  // Future.delayed(const Duration(seconds: 1), () {
  //   navigatorKey.currentState!.pushReplacementNamed('/signin');
  // });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        initialRoute: '/',
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => const MySplash(),
          '/signin': (BuildContext context) => const MyLoginPage(),
          '/signup': (BuildContext context) => const MyRegistrationPage(),
          '/dashboard': (BuildContext context) => const MyDashboard(),
          '/schemes': (BuildContext context) => const MySchemes(),
          '/requests': (BuildContext context) => const MyRequests(),
          '/contact': (BuildContext context) => const MyContact(),
          '/feeds': (BuildContext context) => const MyFeeds(),
          '/profile': (BuildContext context) => const MyProfile(),
        },
      ),
    ),
  );
}
