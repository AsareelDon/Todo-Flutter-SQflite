import 'package:flutter/material.dart';
import 'package:todo_app/screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo SQflite | Flutter',
      theme: ThemeData(
        errorColor: Colors.orange,
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
    );
  }
}

