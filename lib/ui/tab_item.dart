import 'package:flutter/material.dart';

import '../data/model/SourcesResponse.dart';

class TabItem extends StatelessWidget {
  Sources sources;
  bool isSelected;

  TabItem({required this.sources, required this.isSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        decoration: BoxDecoration(
            color: isSelected ? Colors.green : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.green)),
        child: Text(
          sources.name ?? "",
          style: TextStyle(
              fontSize: 18, color: isSelected ? Colors.white : Colors.green),
        ));
  }
}
