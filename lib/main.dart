import 'package:flutter/material.dart';
import 'package:pokedex/core/data_stores/hive_database.dart';

void main() async {
  await HiveDatabase.initialize();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
