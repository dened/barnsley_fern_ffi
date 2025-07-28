import 'package:flutter/material.dart';
import 'package:c_plugin/c_plugin.dart';
void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World! ${sum(4, 5)}'),
        ),
      ),
    );
  }
}
