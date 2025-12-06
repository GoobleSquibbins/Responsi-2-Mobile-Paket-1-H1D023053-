import 'package:flutter/material.dart';
import '/pages/login_page.dart'; // <-- your login page import
import '/pages/items_list_page.dart'; // <-- items page import

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inventaris Komputer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const LoginPage(), // <-- Start here, not the counter page
    );
  }
}
