import 'package:flutter/material.dart';
import 'package:news_project/news_ui.dart';

class HomeScreen extends StatelessWidget {
  static const String routeNamed = "Home";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(image: AssetImage("assets/pattern.png"))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: Drawer(),
        appBar: AppBar(
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          )),
          iconTheme: IconThemeData(color: Colors.white, size: 30),
          backgroundColor: Colors.transparent,
          title: const Text(
            "News App",
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.w300),
          ),
          centerTitle: true,
        ),
        body: const NewsUi(),
      ),
    );
  }
}
