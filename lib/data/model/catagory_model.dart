import 'package:flutter/material.dart';

class CatagoryModel {
  String id;
  String name;
  String image;
  Color color;

  CatagoryModel(
      {required this.id,
      required this.name,
      required this.image,
      required this.color});

  static List<CatagoryModel> getCatagories() {
    return [
      CatagoryModel(
          id: "business",
          name: "Business",
          image: "assets/bussines.png",
          color: Colors.greenAccent),
      CatagoryModel(
          id: "sports",
          name: "Sports",
          image: "assets/sports.png",
          color: Colors.red),
      CatagoryModel(
          id: "entertainment",
          name: "Entertainment",
          image: "assets/environment.png",
          color: Colors.green),
      CatagoryModel(
          id: "general",
          name: "General",
          image: "assets/Politics.png",
          color: Colors.yellowAccent),
      CatagoryModel(
          id: "health",
          name: "Health",
          image: "assets/health.png",
          color: Colors.pink),
      CatagoryModel(
          id: "technology",
          name: "Technology",
          image: "assets/science.png",
          color: Colors.blue),
    ];
  }
}
