import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const String routeNamed = "H";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News App"),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
    );
  }
}
