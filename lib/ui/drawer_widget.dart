import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  Function onClick;

  DrawerWidget({required this.onClick, super.key});

  static const int CATEGORY_ID = 1;
  static const int SETTINGS_ID = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 0.70,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            color: Colors.green,
            alignment: Alignment.center,
            child: Text(
              "News App",
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
          GestureDetector(
            onTap: () {
              onClick(CATEGORY_ID);
            },
            child: Text(
              "Categories",
              style: TextStyle(fontSize: 30, color: Colors.black),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              onClick(SETTINGS_ID);
            },
            child: Text(
              "Setting",
              style: TextStyle(fontSize: 30, color: Colors.black45),
            ),
          ),
        ],
      ),
    );
  }
}
