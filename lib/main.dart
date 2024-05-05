import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import "to_do_page.dart";
import "calendar_page.dart";


void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Список дел",
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  final List<Widget> widgets = [
    const ToDoPage(),
    const CalendarPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 60,
        selectedIndex: index,
        onDestinationSelected: (index) => setState(
          () => this.index = index,
        ),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.rate_review),
            label: "Список дел",
          ),
          NavigationDestination(
            icon: Icon(Icons.insert_invitation),
            label: "Напоминания",
          ),
        ],
      ),
      body: widgets[index],
    );
  }
}
