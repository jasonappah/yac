import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'screens/login.dart';
import 'screens/error.dart';

void main() => runApp(const HomeAccessApp());

class HomeAccessApp extends StatelessWidget {
  const HomeAccessApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    

// TODO after working prototype: Make actual designs and don't use Material

    return MaterialApp(routes: {
      '/': (context) => const LogInScreen(),
      '/grades': (context) => const GradesOverviewScreen(),
    });
  }
}

class GradesOverviewScreen extends StatelessWidget {
  const GradesOverviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: SizedBox(
          width: 400,
          child: Card(
            child: Text("TBA"),
          ),
        ),
      ),
    );
  }
}
