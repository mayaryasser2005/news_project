import 'package:flutter/material.dart';
import 'package:news_project/data/model/catagory_model.dart';

import 'category_tab.dart';
import 'drawer_widget.dart';
import 'news_ui.dart';

class HomeScreen extends StatefulWidget {
  static const String routeNamed = "Home";

  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(image: AssetImage("assets/pattern.png"))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        drawer: DrawerWidget(
          onClick: onDrawerClicked,
        ),
        appBar: AppBar(
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          )),
          iconTheme: IconThemeData(color: Colors.white, size: 30),
          backgroundColor: Colors.green,
          title: const Text(
            "News App",
            style: TextStyle(
                fontSize: 30, color: Colors.white, fontWeight: FontWeight.w300),
          ),
          centerTitle: true,
        ),
        body: catagoryModel == null
            ? CategoryTab(onClick: onCategorySelected)
            : NewsUi(
                id: catagoryModel!.id,
              ),
      ),
    );
  }

  CatagoryModel? catagoryModel;

  onDrawerClicked(id) {
    if (id == DrawerWidget.CATEGORY_ID) {
      catagoryModel = null;
      Navigator.pop(context);
    } else if (id == DrawerWidget.SETTINGS_ID) {}
    setState(() {});
  }

  onCategorySelected(cat) {
    catagoryModel = cat;
    setState(() {});
  }
}
