import 'package:flutter/material.dart';
import 'package:news_project/data/model/catagory_model.dart';

class CategoryItem extends StatelessWidget {
  CatagoryModel catagoryModel;
  bool isOdd;

  CategoryItem({required this.isOdd, required this.catagoryModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: catagoryModel.color,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
              bottomLeft: !isOdd ? Radius.circular(25) : Radius.zero,
              bottomRight: isOdd ? Radius.circular(25) : Radius.zero)),
      child: Column(
        children: [
          Expanded(child: Image.asset(catagoryModel.image)),
          Text(
            catagoryModel.name,
            style: TextStyle(fontSize: 22, color: Colors.white),
          )
        ],
      ),
    );
  }
}
